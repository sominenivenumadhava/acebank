package com.acebank.lite.service;

import com.acebank.lite.models.LoginResult;
import com.acebank.lite.models.ServiceResponse;
import com.acebank.lite.models.Transaction;
import com.acebank.lite.models.User;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface BankService {
    Optional<LoginResult> authenticate(String identifier, String plainPassword) throws SQLException;

    boolean verifyTransactionPin(int accountNo, String rawPin);

    boolean changePassword(int accountNo, String oldPlain, String newPlain) throws SQLException;

    boolean processDeposit(int accountNo, BigDecimal amount);

    BigDecimal getBalance(int accountNo);

    List<Transaction> getTransactionHistory(int accountNo);

    List<Transaction> getFilteredStatement(int accountNo, String fromDate, String toDate);

    ServiceResponse processTransfer(int fromAcc, int toAcc, BigDecimal amount);

    String withdraw(int accountNo, BigDecimal amount);

    Optional<LoginResult> registerUser(User user);

    public boolean recoverAccount(String email);

    public boolean applyForLoan(String firstName, String email, String loanType);
}