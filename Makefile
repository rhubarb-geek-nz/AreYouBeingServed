# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

BINDIR=bin\$(VSCMD_ARG_TGT_ARCH)
APPNAME=dispapp
SVRNAME=dispsvr
TLBNAME=disptlb

all: $(BINDIR) $(BINDIR)\$(SVRNAME).exe $(BINDIR)\$(TLBNAME).dll $(BINDIR)\$(APPNAME).exe

clean:
	if exist $(BINDIR) rmdir /q /s $(BINDIR)
	cd $(SVRNAME)
	$(MAKE) clean
	cd ..
	cd $(APPNAME)
	$(MAKE) clean
	cd ..
	cd $(TLBNAME)
	$(MAKE) clean
	cd ..

$(BINDIR):
	mkdir $@

$(BINDIR)\$(APPNAME).exe: $(APPNAME)\$(BINDIR)\$(APPNAME).exe
	copy $(APPNAME)\$(BINDIR)\$(APPNAME).exe $@

$(BINDIR)\$(SVRNAME).exe: $(SVRNAME)\$(BINDIR)\$(SVRNAME).exe
	copy $(SVRNAME)\$(BINDIR)\$(SVRNAME).exe $@

$(BINDIR)\$(TLBNAME).dll: $(TLBNAME)\$(BINDIR)\$(TLBNAME).dll
	copy $(TLBNAME)\$(BINDIR)\$(TLBNAME).dll $@

$(APPNAME)\$(BINDIR)\$(APPNAME).exe:
	cd $(APPNAME)
	$(MAKE) CertificateThumbprint=$(CertificateThumbprint)
	cd ..

$(SVRNAME)\$(BINDIR)\$(SVRNAME).exe:
	cd $(SVRNAME)
	$(MAKE) CertificateThumbprint=$(CertificateThumbprint)
	cd ..

$(TLBNAME)\$(BINDIR)\$(TLBNAME).dll:
	cd $(TLBNAME)
	$(MAKE) CertificateThumbprint=$(CertificateThumbprint)
	cd ..
