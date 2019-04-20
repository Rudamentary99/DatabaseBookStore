package ui;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Scanner;

import model.HashVal;

public class Main {

	public static void main(String[] args) {
		HashVal test = new HashVal();
	
	
		
		
		System.out.println("Password: \nC0mputer-Sc!enceRoCk$" );
		System.out.println("hash: \n" + test.hashValue("C0mputer-S!enceRoCk$"));
		System.out.println("\nSimilar passwords:");
		System.out.println("different symbols");
		System.out.println(test.hashValue("Computer-Sc!enceRoCk$"));
		System.out.println(test.hashValue("C0mputer-ScienceRoCk$"));
		System.out.println(test.hashValue("C0mputer-Sc!enceRoCks"));
		System.out.println("\ndifferent char order");
		System.out.println(test.hashValue("RoCk$c0mputer-Sc!ence"));
		System.out.println(test.hashValue("-ScienceRoCk$C0mputer"));
		System.out.println(test.hashValue("$kCoRecne!cS-retupm0C"));
	
		
		System.out.println("\ndifferent capitalization");
		System.out.println(test.hashValue("c0mputer-S!enceRoCk$"));
		System.out.println(test.hashValue("C0mputer-sienceRoCk$"));
		System.out.println(test.hashValue("C0mpute-S!enceroCk$"));
		
		
		System.out.println("\nTest\n");
		System.out.println("cat: \n" + test.hashValue("cat"));
		
		System.out.println("cat (should be the same as base case): \n" + test.hashValue("cat"));
		System.out.println("act: \n" + test.hashValue("act"));
		System.out.println("tac: \n" + test.hashValue("tac"));
		
		
		System.out.println("\nvolenteerTest\n");
		System.out.println(test.hashValue("a"));
		System.out.println(test.hashValue("b"));
		System.out.println(test.hashValue("c"));
		System.out.println(test.hashValue("0"));
		
		System.out.println("/nLittle changes make big difference: ");
		System.out.println(test.hashValue("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"));
		System.out.println(test.hashValue("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabaaaaaaaaaaaaaaaaaaaaaa"));
	
	
		System.out.println("collision test: ");
//		int i = 0;
//		int collisions = 0;
//		
//		HashSet<BigInteger> hashes = new HashSet<>();
//	   do {
//		   if (!hashes.add(test.hashValue(Integer.toString(i++)))) {
//			   collisions++;
//			   
//		   }
//		   if (i%1000000 ==0) {
//			   System.err.println(i);
//			   System.out.println("Collisions: " + collisions);
//		   }
//	   } while (i<1000000000);
//	   System.out.println(collisions);
		
	//	collsionTester();
		Presentation();
	 
		
		
	}

	public static void Presentation() {
		Scanner keyboard = new Scanner(System.in);
		HashVal hasher = new HashVal();
		String valToHash;
		
		boolean presenting = false;
		
		System.err.println("\nThe Amazing Hasher\n");
		System.out.println("Please enter the String you would like to hash \nor\nenter -1 to cancel the presentation!");	
		do {
		valToHash = keyboard.nextLine();
		
		if (valToHash.equals("-1")) {
			presenting = false;
		} else {
			presenting = true; 
			String hash = hasher.hashValue(valToHash).toString();
		
			System.out.println(hash);
		}
			
		} while (presenting);
		
		keyboard.close();
	}
	public static void collsionTester() {
		String val = "";
		int collisions = 0;
		int counter = 0; 
		HashSet<BigInteger> set = new HashSet<>();
		
		HashVal Hasher = new HashVal();
		
//		set.add(Hasher.hashValue("!!!!"));
		for (int a = (int)'!'; a<=(int)'}'; a++ ) {
			for (int b = (int)'!'; b<=(int)'}'; b++ ) {
				for (int c = (int)'!'; c<=(int)'}'; c++ ) {
					for (int d = (int)'!'; d<=(int)'}'; d++ ) {
						val += (char)a;
						val += (char)b;
						val += (char)c;
						val += (char)d;
						//System.out.println(val);
						
						if (!set.add(Hasher.hashValue(val))) {
							collisions++;
							System.out.println(collisions);
							System.out.println(val);
						}
					
//						if (counter%92 ==0) {
//							System.out.println("collisions thus far: " + collisions);
//							System.out.println("current string: " + val);
//							System.out.println("hash: " + Hasher.hashValue(val));
//						}
						val = "";
						counter++; 
					}
			
				}
				if (counter%92 ==0) {
					System.out.println("collisions thus far: " + collisions);
					System.out.println("current string: " + val);
					System.out.println("hash: " + Hasher.hashValue(val));
				}
				
			}
		}
		System.out.println("collisions: " + collisions);
		
		
	}
}
