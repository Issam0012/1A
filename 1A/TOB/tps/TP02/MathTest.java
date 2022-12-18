import static org.junit.Assert.*;

import org.junit.Test;

public class MathTest {

	@Test
	public void testSqrt() {
		assertEquals(Math.sqrt(4.0), 2.0, 1e-6);
	}

}
