/***********************************
 * Copyright (c) 2024 Roger Brown.
 * Licensed under the MIT License.
 ****/

using System;
using System.Reflection;

namespace dispnet
{
    internal class Program
    {
        static void Main(string[] args)
        {
            object helloWorld = Activator.CreateInstance(Type.GetTypeFromProgID("RhubarbGeekNz.AreYouBeingServed"));

            object result = helloWorld.GetType().InvokeMember("GetMessage", BindingFlags.Public | BindingFlags.Instance | BindingFlags.InvokeMethod, null, helloWorld, new object[] { 1 });

            Console.WriteLine($"{result}");
        }
    }
}
