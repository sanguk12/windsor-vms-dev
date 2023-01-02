package kr.co.nis.waf.system.common.model;

import java.util.Arrays;
import java.util.List;

import kr.co.nis.waf.mvc.Model;

public class SwitchObject extends CommonObject implements Model {

	private static String testModuleYN = "Y";
	private static List<String> testModule_views = Arrays.asList (
		"CMP01003C"
		, "CMP01003D"
	);
	private static List<String> testModule_queryKeys = Arrays.asList (
		"updateCode"
		, "deleteCode"
	);
	
//	private static String testModule_views[] = {
//		"CMP01003C"
//		, "CMP01003D"
//	};
//	private static String testModule_queryKeys[] = {
//		"detailCode"
//		, "detailCode2"
//	};
	
	public void clean() throws Exception {
	}

	public void validate(int action) throws Exception {
	}

	public static String getTestModuleYN() {
		return testModuleYN;
	}

	public static void setTestModuleYN(String testModuleYN) {
		SwitchObject.testModuleYN = testModuleYN;
	}

	public static List<String> getTestModule_views() {
		return testModule_views;
	}

	public static void setTestModule_views(List<String> testModule_views) {
		SwitchObject.testModule_views = testModule_views;
	}

	public static List<String> getTestModule_queryKeys() {
		return testModule_queryKeys;
	}

	public static void setTestModule_queryKeys(List<String> testModule_queryKeys) {
		SwitchObject.testModule_queryKeys = testModule_queryKeys;
	}

}