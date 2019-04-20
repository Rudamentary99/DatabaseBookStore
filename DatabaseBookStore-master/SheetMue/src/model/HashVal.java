package model;

import java.math.BigInteger;

public class HashVal {
	private BigInteger hash;
	private final double gold = 1.61803398875;
	private final BigInteger golden = BigInteger.valueOf((long) (Math.pow(2, 64) / 1.61803398875));

	public BigInteger hashValue(String pString) {
		System.out.println("Hashing");
		String string = pString;
		for (int i = 0; i < string.length(); i++) {
			int letter = string.charAt(i);
			if (i == 0) {
				hash = BigInteger.valueOf(letter * 31);
			} else {
				int prevLetter = string.charAt(i - 1);
				BigInteger val = BigInteger.valueOf((long) (letter * ((prevLetter * 131)/gold)));
				hash = hash.add(val);
				mashUp();
			}
		}
		return hash;
	}

	private void mashUp() {
		String skinnedPotatoes = hash.toString();
		String mashedPotatoes = "";
		for (int i = 0; i < skinnedPotatoes.length() - 1; i++) {
			mashedPotatoes += skinnedPotatoes.charAt(i) * skinnedPotatoes.charAt(i + 1);
		}
		hash = new BigInteger(mashedPotatoes);
		hash = hash.mod(golden);
	}


	
}
