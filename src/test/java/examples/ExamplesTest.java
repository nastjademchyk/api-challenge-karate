package examples;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import com.intuit.karate.junit5.Karate;

public class ExamplesTest {

    @Karate.Test
    Karate runAll() {
        return Karate.run().relativeTo(getClass());
    }
}

