/*
Copyright © 2021, devolo AG
All rights reserved.

This source code is licensed under the BSD-style license found in the
LICENSE file in the root directory of this source tree.
*/

class DataratePair {
  int tx = 0;
  int rx = 0;

  DataratePair(int rx, int tx) {
    this.rx = rx;
    this.tx = tx;
  }
}
