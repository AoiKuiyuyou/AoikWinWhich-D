# AoikWinWhich-D
[AoikWinWhich](https://github.com/AoiKuiyuyou/AoikWinWhich) written in D.

D: 2.066

## Contents
- [How to install](#how-to-install)
- [How to use](#how-to-use)

## How to install
Clone the repo to local.

## How to use
Go to the local repo dir.

The program entry file is [src/aoikwinwhich/aoikwinwhich.d](/src/aoikwinwhich/aoikwinwhich.d).

Use dmd to compile.
```
dmd -ofbuild/aoikwinwhich.exe -odbuild -op src/aoikwinwhich/aoikwinwhich.d
```
- ```-ofbuild/aoikwinwhich.exe``` means put result executable file at **build/aoikwinwhich.exe**.
- ```-odbuild``` means put **.obj** files in **build** dir.
- ```-op``` means preserve the original package hierarchy when putting **.obj** files in output dir.

Run.
```
build\aoikwinwhich.exe
```

See [here](https://github.com/AoiKuiyuyou/AoikWinWhich#how-to-use) for more usage and [AoikWinWhich](https://github.com/AoiKuiyuyou/AoikWinWhich) for more info.
