package api.runners;


import java.util.List;

import com.intuit.karate.junit5.Karate;

public class KarateTestRunners {

	@Karate.Test
	public Karate runTests() {
		//run() method required path to feature files.
		//you can use tags() method to specify the Tags.
		return Karate.run("classpath:features")
				.tags(List.of("Smoke" , "Regression"));
	}
}
