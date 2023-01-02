package kr.co.nis.waf.system.common.model;

import java.util.Random;

public class RandomGenerator {
	
	public RandomGenerator() {
		
	}
	
	public String getData(int length) {
		Random random = new Random();
		StringBuffer str = new StringBuffer();

		for (int i=0; i<length; i++) {
			if ( random.nextBoolean() ) {
				str.append(String.valueOf((char)((int)(random.nextInt(26))+97)).toUpperCase());
			}
			else {
				str.append((random.nextInt(10))); 
			}
		}
		return str.toString();
	}
	
}