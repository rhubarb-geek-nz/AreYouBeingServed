# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

param(
	$CertificateThumbprint = '601A8B683F791E51F647D34AD102C38DA4DDB65F',
	$Architectures = @('arm', 'arm64', 'x86', 'x64')
)

$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'

trap
{
	throw $PSItem
}

foreach ($ARCH in $Architectures)
{
	$VERSION=(Get-Item "..\bin\$ARCH\RhubarbGeekNzAreYouBeingServed.exe").VersionInfo.ProductVersion

	$env:PRODUCTVERSION = $VERSION
	$env:PRODUCTARCH = $ARCH
	$env:PRODUCTWIN64 = 'yes'
	$env:PRODUCTPROGFILES = 'ProgramFiles64Folder'
	$env:INSTALLERVERSION = '500'

	switch ($ARCH)
	{
		'arm64' {
			$env:UPGRADECODE = '87C2F9B7-CEEF-4BF2-96F6-014616DDA6B0'
		}

		'arm' {
			$env:UPGRADECODE = '90DB4252-092A-49C6-B050-9E23FAB07DB6'
			$env:PRODUCTWIN64 = 'no'
			$env:PRODUCTPROGFILES = 'ProgramFilesFolder'
		}

		'x86' {
			$env:UPGRADECODE = '497EA2F0-3C21-41C2-9B38-45677A16184B'
			$env:PRODUCTWIN64 = 'no'
			$env:PRODUCTPROGFILES = 'ProgramFilesFolder'
			$env:INSTALLERVERSION = '200'
		}

		'x64' {
			$env:UPGRADECODE = 'C77147B0-4BB2-4E19-AD0B-5304B1FA60B4'
			$env:INSTALLERVERSION = '200'
		}
	}	

	& "${env:WIX}bin\candle.exe" -nologo "dispsvr.wxs"

	if ($LastExitCode -ne 0)
	{
		exit $LastExitCode
	}

	$MsiFilename = "rhubarb-geek-nz.AreYouBeingServed-$VERSION-$ARCH.msi"

	& "${env:WIX}bin\light.exe" -nologo -cultures:null -out $MsiFilename 'dispsvr.wixobj'

	if ($LastExitCode -ne 0)
	{
		exit $LastExitCode
	}

	Remove-Item 'dispsvr.wix*'
	Remove-Item 'rhubarb-geek-nz.AreYouBeingServed-*.wixpdb'

	if ($CertificateThumbprint)
	{
		$codeSignCertificate = Get-ChildItem -path Cert:\ -Recurse -CodeSigningCert | Where-Object { $_.Thumbprint -eq $CertificateThumbprint }

		if ($codeSignCertificate -and ($codeSignCertificate.Count -eq 1))
		{
			$result = Set-AuthenticodeSignature -FilePath $MsiFilename -HashAlgorithm 'SHA256' -Certificate $codeSignCertificate -TimestampServer 'http://timestamp.digicert.com'
		}
		else
		{
			Write-Error "Error with certificate - $CertificateThumbprint"
		}
	}
}
