/***********************************
 * Copyright (c) 2024 Roger Brown.
 * Licensed under the MIT License.
 ****/

#include <objbase.h>
#include <stdio.h>

int main(int argc, char** argv)
{
	HRESULT hr = CoInitializeEx(NULL, COINIT_MULTITHREADED);

	if (SUCCEEDED(hr))
	{
		BSTR app = SysAllocString(L"RhubarbGeekNz.AreYouBeingServed");
		CLSID clsid;

		hr = CLSIDFromProgID(app, &clsid);

		SysFreeString(app);

		if (SUCCEEDED(hr))
		{
			IDispatch* helloWorld = NULL;

			hr = CoCreateInstance(clsid, NULL, CLSCTX_LOCAL_SERVER, IID_IDispatch, (void**)&helloWorld);

			if (SUCCEEDED(hr))
			{
				BSTR names[] = { SysAllocString(L"GetMessage") };
				DISPID dispIds[sizeof(names) / sizeof(names[0])];
				int namesCount = sizeof(names) / sizeof(names[0]);

				hr = helloWorld->GetIDsOfNames(IID_NULL, names, namesCount, LOCALE_USER_DEFAULT, dispIds);

				if (SUCCEEDED(hr))
				{
					VARIANT result;
					DISPPARAMS params = { 0,0,0,0 };
					UINT argErr;
					EXCEPINFO ex;
					VARIANTARG arg;

					arg.vt = VT_I4;
					arg.intVal = 1;
					params.cArgs = 1;
					params.rgvarg = &arg;

					ZeroMemory(&ex, sizeof(ex));

					VariantInit(&result);

					hr = helloWorld->Invoke(dispIds[0], IID_NULL, LOCALE_USER_DEFAULT, DISPATCH_METHOD, &params, &result, &ex, &argErr);

					if (result.vt == VT_BSTR)
					{
						printf("%S\n", result.bstrVal);
					}

					VariantClear(&result);
				}

				while (namesCount--)
				{
					SysFreeString(names[namesCount]);
				}

				helloWorld->Release();
			}
		}

		CoUninitialize();
	}

	if (FAILED(hr))
	{
		fprintf(stderr, "0x%lx\n", (long)hr);
	}

	return FAILED(hr);
}
