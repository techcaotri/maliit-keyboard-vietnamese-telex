#include "vietnameseplugin.h"
#include "vietnameselanguagefeatures.h"
#include "spellpredictworker.h"

#include <QDebug>

VietnamesePlugin::VietnamesePlugin(QObject *parent) :
    AbstractLanguagePlugin(parent)
  , m_vietnameseLanguageFeatures(new VietnameseLanguageFeatures)
  , m_spellCheckEnabled(false)
  , m_processingSpelling(false)
{
    m_spellPredictThread = new QThread();
    m_spellPredictWorker = new SpellPredictWorker();
    m_spellPredictWorker->moveToThread(m_spellPredictThread);

    connect(m_spellPredictWorker, &SpellPredictWorker::newSpellingSuggestions, this, &VietnamesePlugin::spellCheckFinishedProcessing);
    connect(m_spellPredictWorker, &SpellPredictWorker::newPredictionSuggestions, this, &VietnamesePlugin::newPredictionSuggestions);
    connect(this, &VietnamesePlugin::newSpellCheckWord, m_spellPredictWorker, &SpellPredictWorker::newSpellCheckWord);
    connect(this, &VietnamesePlugin::setSpellPredictLanguage, m_spellPredictWorker, &SpellPredictWorker::setLanguage);
    connect(this, &VietnamesePlugin::setSpellCheckLimit, m_spellPredictWorker, &SpellPredictWorker::setSpellCheckLimit);
    connect(this, &VietnamesePlugin::parsePredictionText, m_spellPredictWorker, &SpellPredictWorker::parsePredictionText);
    connect(this, &VietnamesePlugin::addToUserWordList, m_spellPredictWorker, &SpellPredictWorker::addToUserWordList);
    connect(this, &VietnamesePlugin::addOverride, m_spellPredictWorker, &SpellPredictWorker::addOverride);
    m_spellPredictThread->start();

}

VietnamesePlugin::~VietnamesePlugin()
{
    m_spellPredictWorker->deleteLater();
    m_spellPredictThread->quit();
    m_spellPredictThread->wait();
}

AbstractLanguageFeatures* VietnamesePlugin::languageFeature()
{
    return m_vietnameseLanguageFeatures;
}

void VietnamesePlugin::predict(const QString& surroundingLeft, const QString& preedit)
{
    Q_EMIT parsePredictionText(surroundingLeft, preedit);
}

void VietnamesePlugin::wordCandidateSelected(QString word)
{
    Q_UNUSED(word);
}


void VietnamesePlugin::spellCheckerSuggest(const QString& word, int limit)
{
    m_nextSpellWord = word;
    // Don't accept new words whilst we're processing, so we only process the
    // most recent input once the current processing has completed
    if (!m_processingSpelling) {
        m_processingSpelling = true;
        Q_EMIT setSpellCheckLimit(limit);
        Q_EMIT newSpellCheckWord(word);
    }
}

void VietnamesePlugin::addToSpellCheckerUserWordList(const QString& word)
{
    Q_EMIT addToUserWordList(word);
}

bool VietnamesePlugin::setLanguage(const QString& languageId, const QString& pluginPath)
{
    Q_EMIT setSpellPredictLanguage(languageId, pluginPath);
    loadOverrides(pluginPath);
    return true;
}

void VietnamesePlugin::addSpellingOverride(const QString& orig, const QString& overridden)
{
    Q_EMIT addOverride(orig, overridden);
}

void VietnamesePlugin::loadOverrides(const QString& pluginPath) {
    QFile overrideFile(pluginPath + QDir::separator() + "overrides.csv");
    if (overrideFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream overrideStream(&overrideFile);
        while (!overrideStream.atEnd()) {
            QString line = overrideStream.readLine();
            QStringList components = line.split(QStringLiteral(","));
            if (components.length() == 2) {
                addSpellingOverride(components.first(), components.last());
            }
        }
    }
}

void VietnamesePlugin::spellCheckFinishedProcessing(QString word, QStringList suggestions) {
    Q_EMIT newSpellingSuggestions(word, suggestions);
    if (word != m_nextSpellWord) {
        Q_EMIT newSpellCheckWord(m_nextSpellWord);
    } else {
        m_processingSpelling = false;
    }
}
