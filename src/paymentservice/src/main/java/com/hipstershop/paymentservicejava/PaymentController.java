package com.hipstershop.paymentservicejava;

import java.io.InputStream;
import java.net.URL;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.Random;
import java.util.logging.Logger;

import javax.persistence.LockTimeoutException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.hipstershop.paymentservicejava.dataaccess.PaymentRecordRepository;
import com.hipstershop.paymentservicejava.model.PaymentRecord;

import hipstershop.Payment.ChargeRequest;

@Component
public class PaymentController {

    private Logger log = Logger.getLogger("PaymentController");

    @Autowired
    PaymentRecordRepository repo;

    public String clearPayment(ChargeRequest request) throws LockTimeoutException {
        String currency = request.getAmount().getCurrencyCode();
        Long amount = request.getAmount().getUnits();
        int nanos = request.getAmount().getNanos();
        String ccNumber = request.getCreditCard().getCreditCardNumber();

        log.info(String.format("Processing transaction: %s ending %s Amount: %s%d.%d",
            this.getCardtypeByNumber(ccNumber),
            ccNumber.substring(ccNumber.length()-5),
            currency,
            amount,
            nanos));

        return generateTransactionId();
    }

    private String generateTransactionId() {
        byte[] array = new byte[7]; // length is bounded by 7
        new Random().nextBytes(array);
        return new String(array, Charset.forName("UTF-8"));
    }


    private String getCardtypeByNumber(String creditcardNumber) {
        if(creditcardNumber.startsWith("4")) {
            return "Visa";
        } else if(creditcardNumber.startsWith("34") || creditcardNumber.startsWith("37")) {
            return "American Express";
        } else if(creditcardNumber.startsWith("5")) {
            return "Mastercard";
        } else {
            return "other";
        }

    }
}
