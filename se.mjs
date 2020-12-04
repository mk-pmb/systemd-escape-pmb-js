// -*- coding: utf-8, tab-width: 2 -*-

const escCharsRgx = /^\.|[^\.\/0-9A-Z_a-z]/g;


function bufHex(s) {
  return Buffer.from(s, 'UTF-8').toString('hex').replace(/(\S{2})/g, '\\x$1');
}

function bufUnHex(h) {
  return Buffer.from(h.replace(/\\x/g, ''), 'hex').toString('UTF-8');
}


const EX = {

  escCharsRgx,

  escapeCustom(opt, input) {
    const { path } = (opt || false);
    let s = input;
    if (path) { s = s.replace(/^\/+|\/+(?=\/|$)/g, ''); }
    s = s.replace(escCharsRgx, bufHex).replace(/\//g, '-');
    return s;
  },

  escapeNonPath(input) { return EX.escapeCustom(false, input); },
  escapePath(input) { return EX.escapeCustom({ path: true }, input); },

  unescapeCustom(opt, input) {
    const { path } = (opt || false);
    let s = input;
    if (path) { s = '/' + s; }
    s = s.replace(/\-/g, '/').replace(/(?:\\x[0-9A-Fa-f]{2})+/g, bufUnHex);
    return s;
  },

  unescapeNonPath(input) { return EX.unescapeCustom(false, input); },
  unescapePath(input) { return EX.unescapeCustom({ path: true }, input); },
};


export default EX;
