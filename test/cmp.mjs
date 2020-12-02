// -*- coding: utf-8, tab-width: 2 -*-

import 'p-fatal';
import 'usnam-pmb';

import vTry from 'vtry';
import equal from 'equal-pmb';
import readDataFile from 'read-data-file';

import sdEsc from '..';


const inputFiles = [
  '01_basics.json',
];


function cmpOneExample(trace, ex) {
  if (!ex) { return; }
  function q(a, m, b) { equal(sdEsc[m](ex[a]), ex[b]); }
  function v(a, m, b) { vTry(q, `${trace}, ${m}(${a}) -> ${b}`)(a, m, b); }
  v('plain', 'escapeNonPath', 'str');
  v('plain', 'escapePath',    'path');
  if (ex.plain.startsWith('/')) {
    v('path', 'unescapePath', 'plain');
  } else {
    v('str', 'unescapeNonPath', 'plain');
  }
}


async function cmpTest(filename) {
  console.debug('#', filename);
  const examples = await readDataFile(filename);
  examples.forEach((x, i) => cmpOneExample(`${filename} #${i + 1}`, x));
}



(async function main() {
  await inputFiles.reduce(async function chain(old, cur) {
    await old;
    return cmpTest(cur);
  }, 1);
  console.info('+OK cmp.mjs test passed.');
}());
