const memory = new WebAssembly.Memory({ initial: 1 });

const importObject = {
    "document": {
      getElementById(id) {
        return document.getElementById(id);
      },
      setInnerText(element, str) {
        element.innerText = str;
      },
      log(x) {
        console.log(x);
      },

    },
    "js": {
      "memory": memory,
      readString(address, length) {
        const uint8Array = new Uint8Array(memory.buffer, address, length);
        return new TextDecoder('utf-8').decode(uint8Array);
      }
    },
  };
  
  var button = () => {};

  WebAssembly.instantiateStreaming(fetch("/algoritmizace/wasm.wasm"), importObject).then(
    (obj) => {
        button = obj.instance.exports.button;
        let err = obj.instance.exports.main();
        if (err !== 0) console.log(err);
    },
  );
  
