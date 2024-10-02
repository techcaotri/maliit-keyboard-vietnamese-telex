.pragma library
.import "avim.js" as AVIM

var AVIMObj;

function initAVIM() {
    if (typeof AVIM.AVIM !== 'undefined' && !AVIMObj) {
        AVIMObj = new AVIM.AVIM();
        console.log("AVIM object created");
    } else if (!AVIM.AVIM) {
        console.error("AVIM is not defined. Make sure the script is loaded correctly.");
    }
}

function handleKeyPress(event, textArea) {
    if (!AVIMObj) {
        console.error("AVIM object is not initialized");
        return true;
    }

    var e = {
        which: event.key,
        target: {
            selectionStart: textArea.selectionStart,
            selectionEnd: textArea.selectionEnd,
            value: textArea.text,
            type: "textarea",
            setSelectionRange(start, end) {
                this.selectionStart = start;
                this.selectionEnd = end;
            }
        }
    };

    var result = AVIMObj.keyPressHandler(e);

    if (result === false) {
        textArea.text = e.target.value;
        textArea.cursorPosition = e.target.selectionStart;
    }

    return result;
}

function setInputMethod(method) {
    if (!AVIMObj) {
        console.error("AVIM object is not initialized");
        return;
    }

    AVIMObj.setMethod(method);
    console.log("Input method set to:", method);
}
