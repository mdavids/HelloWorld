#!/usr/bin/python
# Copyright (C) 2014 SIDN Labs
# Author: Arjen Zonneveld, Marco Davids, Jelte Jansen
# Version 0.1 - 20141008
import dkim
import sys

try:
  dKI = dkim.DKIM(message=open('./test.eml').read())
  if dKI.verify():
    print("DKIM is ok.")
    sys.exit(0)
  else:
    print("DKIM klopt niet!")
    sys.exit(1)
except dkim.ValidationError, dVE:
  print("Validatiefout: " + str(dVE))
  sys.exit(1)
except dkim.KeyFormatError, dVE:
  print("Sleutel-formaat fout: " + str(dVE))
  sys.exit(1)
except dkim.MessageFormatError, dVE:
  print("Bericht-formaat fout: " + str(dVE))
  sys.exit(1)  
