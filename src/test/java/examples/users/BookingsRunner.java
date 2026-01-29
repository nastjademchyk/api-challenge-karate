package examples.bookings;

import com.intuit.karate.junit5.Karate;

class BookingsRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run().relativeTo(getClass());
    }

}
