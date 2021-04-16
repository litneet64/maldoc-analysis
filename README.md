![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/litneet64/maldoc-analysis) ![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/litneet64/maldoc-analysis) ![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/litneet64/maldoc-analysis) ![GitHub](https://img.shields.io/github/license/litneet64/maldoc-analysis)
# Maldoc Analysis
Dockerfile for maldoc analysis purposes.

## Introduction
Contains all the major tools used for MS Office files' analysis:

* ViperMonkey
* OleDump **+** all plugins
* YARA **+** yara-python
* Those included in oletools:
  * OleVBA
  * OleDir
  * OleMap
  * [And more...](https://github.com/decalage2/oletools/wiki#tools-in-python-oletools)

## Usage
```bash
$ podman run -it --rm -v ./my_ole_files:/playground/ole_files litneet64/maldoc-analysis
```

Inside the container, you can use the tools as:
```bash
analyst@4bd1ba63266d:/playground$ ./oledump.py ole_files/emotet.doc
1:       114 '\x01CompObj'
2:      4096 '\x05DocumentSummaryInformation'
3:      4096 '\x05SummaryInformation'
4:      7544 '1Table'
5:        97 'Macros/Get4ipjzmjfvp/\x01CompObj'
6:       296 'Macros/Get4ipjzmjfvp/\x03VBFrame'
7:       231 'Macros/Get4ipjzmjfvp/f'
8:       232 'Macros/Get4ipjzmjfvp/o'
9:       601 'Macros/PROJECT'
10:       134 'Macros/PROJECTwm'
11: M    1442 'Macros/VBA/Dw75ayd2hpcab6'
12: M   34177 'Macros/VBA/Get4ipjzmjfvp'
13: M    3452 'Macros/VBA/Rk3572j7tam4v8'
14:     11093 'Macros/VBA/_VBA_PROJECT'
15:       913 'Macros/VBA/dir'
16:    134771 'WordDocument'
analyst@4bd1ba63266d:/playground$
analyst@4bd1ba63266d:/playground$
analyst@4bd1ba63266d:/playground$ olevba ole_files/emotet.doc
.
. # stripped as output is too long
.
-------------------------------------------------------------------------------
VBA FORM Variable "Cn8r2cg8i626ztt" IN 'ole_files/emotet.doc' - OLE stream: u'Macros/Get4ipjzmjfvp'
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
][(s)]wtu][(s)]w
+----------+--------------------+---------------------------------------------+
|Type      |Keyword             |Description                                  |
+----------+--------------------+---------------------------------------------+
|AutoExec  |Document_open       |Runs when the Word or Publisher document is  |
|          |                    |opened                                       |
|Suspicious|Create              |May execute file or a system command through |
|          |                    |WMI                                          |
|Suspicious|CreateObject        |May create an OLE object                     |
|Suspicious|ChrW                |May attempt to obfuscate specific strings    |
|          |                    |(use option --deobf to deobfuscate)          |
|Suspicious|Hex Strings         |Hex-encoded strings were detected, may be    |
|          |                    |used to obfuscate strings (option --decode to|
|          |                    |see all)                                     |
+----------+--------------------+---------------------------------------------+
```

## Tips / Resources
This is not the only way for analyzing a maldoc, as most tools here are meant for static analysis (except for ViperMonkey). You can actually get more useful information to grasp what the macros are doing via dynamic analysis (AKA running the macros). A good way for doing this is using [AnyRun's](https://app.any.run/) sandbox services.

More resources for usage of the tools mentioned above:

* [OleTools official page](http://www.decalage.info/en/python/oletools)
* [OleDump official page](https://blog.didierstevens.com/programs/oledump-py/)
* [ViperMonkey official page](https://www.decalage.info/en/vba_emulation)
* [Usage of plugin_biff in Oledump (and plugins in general)](https://blog.didierstevens.com/2019/03/15/maldoc-excel-4-0-macro/)
