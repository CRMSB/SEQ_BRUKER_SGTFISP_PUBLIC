# SEQ_BRUKER_SGTFISP_PUBLIC

Bruker Sequence : TFISP + SG module
This repository regroups the compiled sequence and matlab reconstruction of the MP2RAGE+CS sequence. This repository is still in beta don't hesitate to open a issue and share your comments.

Sequence principle is described in this MRM publication : [![DOI](https://zenodo.org/badge/DOI/10.1002/jmri.24688.svg)](https://doi.org/10.1002/jmri.24688)

Source code is available as a private submodule if you want the source code, send a request to : aurelien.trotier@rmsb.u-bordeaux.fr

## Sequence installation

Sequence has been developped for Paravision **PV6.0.1**. Minor modification are required for PV6.0 compatibility (feel free to contact us)

**Installation step :**

* Copy the binary sequence under the folder
  `/opt/PV6.0.1/share/`

* To install : `File -> Import -> Binary Method ` and select the sequence in the share folder.


Sequence is now install and available under the **Palette** tab/Explorer tab/Scan Programs & Protocols :

```
Object : AnyObject
Region : AnyRegion
Application : UserMethods
```

To use it drag and drop to an exam card.

## Acquisition


## Recontruction

**Requirements :**

* Matlab (tested on version > 2016b