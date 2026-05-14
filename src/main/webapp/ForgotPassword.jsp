<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Forgot Password | Ace Bank</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
            <style>
                html,
                body {
                    height: 100%;
                }

                body {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    min-height: 100vh;
                    background: linear-gradient(160deg, #EEF2FF 0%, #F9FAFB 100%);
                    padding: 2rem;
                }

                .forgot-card {
                    background: var(--color-surface);
                    border: 1px solid var(--color-border);
                    border-radius: var(--radius-xl);
                    box-shadow: var(--shadow-md);
                    padding: 2.5rem;
                    width: 100%;
                    max-width: 440px;
                }

                .forgot-card-logo {
                    font-size: 1.25rem;
                    font-weight: 700;
                    color: var(--color-text-primary);
                    margin-bottom: 2rem;
                    display: block;
                    text-decoration: none;
                }

                .forgot-card-logo span {
                    color: var(--color-primary);
                }

                .step-icon {
                    width: 64px;
                    height: 64px;
                    background: var(--color-primary-light);
                    border: 2px solid rgba(124, 158, 255, 0.3);
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.75rem;
                    margin-bottom: 1.5rem;
                }

                .forgot-title {
                    font-size: 1.5rem;
                    font-weight: 800;
                    margin-bottom: 0.5rem;
                }

                .forgot-sub {
                    color: var(--color-text-secondary);
                    font-size: var(--font-size-sm);
                    margin-bottom: 2rem;
                    line-height: 1.65;
                }

                .back-link {
                    display: inline-flex;
                    align-items: center;
                    gap: 0.375rem;
                    color: var(--color-text-secondary);
                    font-size: var(--font-size-sm);
                    margin-top: 1.25rem;
                }

                .back-link:hover {
                    color: var(--color-primary);
                }
            </style>
        </head>

        <body>

            <div class="forgot-card fade-in-up">
                <a href="${pageContext.request.contextPath}/" class="forgot-card-logo">Ace<span>Bank</span></a>

                <div class="step-icon">🔑</div>

                <h1 class="forgot-title">Reset Password</h1>
                <p class="forgot-sub">
                    Enter your registered email address. We'll send you a one-time password (OTP) to reset your account
                    password.
                </p>

                <!-- Success Message -->
                <c:if test="${not empty param.sent}">
                    <div class="alert alert-success" style="margin-bottom:1.5rem;">
                        ✓ OTP sent! Check your inbox and follow the instructions.
                    </div>
                </c:if>

                <!-- Error Message -->
                <c:if test="${not empty param.error}">
                    <div class="alert alert-error" style="margin-bottom:1.5rem;">
                        ⚠ ${param.error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/forgotPassword" method="POST" novalidate>

                    <div class="form-group">
                        <label class="form-label" for="email">Email Address</label>
                        <input class="form-input" type="email" id="email" name="email" placeholder="you@example.com"
                            required autocomplete="email">
                    </div>

                    <button type="submit" class="btn btn-primary btn-full" style="padding: 0.8rem; font-size: 1rem;">
                        Send OTP
                    </button>

                </form>

                <a href="${pageContext.request.contextPath}/login.jsp" class="back-link">← Back to Login</a>
            </div>

        </body>

        </html>