/***********************************
 * Copyright (c) 2024 Roger Brown.
 * Licensed under the MIT License.
 ****/

using System;

namespace RhubarbGeekNzAreYouBeingServed
{
    internal class Program
    {
        static void Main(string[] args)
        {
            IHelloWorld helloWorld = new CHelloWorld();

            string result = helloWorld.GetMessage(args.Length > 0 ? Int32.Parse(args[0]) : 1);

            Console.WriteLine($"{result}");
        }
    }
}
