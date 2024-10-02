#ifndef VIETNAMESEPLUGIN_H
#define VIETNAMESEPLUGIN_H

#include <QObject>
#include <QStringList>
#include "languageplugininterface.h"
#include "abstractlanguageplugin.h"
#include "spellchecker.h"
#include "spellpredictworker.h"

#include <iostream>

class VietnameseLanguageFeatures;

class VietnamesePlugin : public AbstractLanguagePlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "io.maliit.keyboard.LanguagePlugin.1" FILE "vietnameseplugin.json")
    Q_INTERFACES(LanguagePluginInterface)

public:
    explicit VietnamesePlugin(QObject *parent = nullptr);
    ~VietnamesePlugin() override;

    void predict(const QString& surroundingLeft, const QString& preedit) override;
    void wordCandidateSelected(QString word) override;
    AbstractLanguageFeatures* languageFeature() override;

    //! spell checker
    void spellCheckerSuggest(const QString& word, int limit) override;
    void addToSpellCheckerUserWordList(const QString& word) override;
    bool setLanguage(const QString& languageId, const QString& pluginPath) override;
    virtual void addSpellingOverride(const QString& orig, const QString& overridden);
    virtual void loadOverrides(const QString& pluginPath);

signals:
    void newSpellCheckWord(QString word);
    void setSpellCheckLimit(int limit);
    void setSpellPredictLanguage(QString language, QString pluginPath);
    void parsePredictionText(QString surroundingLeft, QString preedit);
    void setPredictionLanguage(QString language);
    void addToUserWordList(const QString& word);
    void addOverride(const QString& orig, const QString& overridden);

public slots:
    void spellCheckFinishedProcessing(QString word, QStringList suggestions);

private:
    VietnameseLanguageFeatures* m_vietnameseLanguageFeatures;
    SpellPredictWorker *m_spellPredictWorker;
    QThread *m_spellPredictThread;
    bool m_spellCheckEnabled;
    QString m_nextSpellWord;
    bool m_processingSpelling;
};

#endif // VIETNAMESEPLUGIN_H
