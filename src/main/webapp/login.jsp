<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta name="description" content="Login to your Ace Bank account securely.">
            <title>Login | Ace Bank</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
            <style>
                /* ── Auth Layout ───────────────────────── */
                html,
                body {
                    height: 100%;
                }

                body {
                    display: flex;
                    min-height: 100vh;
                    background: var(--color-bg);
                }

                .auth-page {
                    display: flex;
                    width: 100%;
                    min-height: 100vh;
                }

                /* Left Branding Panel */
                .auth-panel {
                    flex: 0 0 400px;
                    background: linear-gradient(160deg, #EEF2FF 0%, #E8FDF5 100%);
                    border-right: 1px solid var(--color-border);
                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                    padding: 3rem;
                    position: relative;
                    overflow: hidden;
                }

                .auth-panel::before {
                    content: '';
                    position: absolute;
                    width: 350px;
                    height: 350px;
                    background: radial-gradient(circle, rgba(124, 158, 255, 0.15) 0%, transparent 70%);
                    bottom: -50px;
                    right: -80px;
                    pointer-events: none;
                }

                .auth-panel-logo {
                    font-size: 1.5rem;
                    font-weight: 700;
                    color: var(--color-text-primary);
                    position: relative;
                    z-index: 1;
                }

                .auth-panel-logo span {
                    color: var(--color-primary);
                }

                .auth-panel-copy {
                    position: relative;
                    z-index: 1;
                }

                .auth-panel-quote {
                    font-size: 1.6rem;
                    font-weight: 800;
                    line-height: 1.25;
                    color: var(--color-text-primary);
                    margin-bottom: 1rem;
                }

                .auth-panel-sub {
                    font-size: var(--font-size-sm);
                    color: var(--color-text-secondary);
                    line-height: 1.65;
                }

                .auth-panel-footer {
                    font-size: var(--font-size-xs);
                    color: var(--color-text-muted);
                    position: relative;
                    z-index: 1;
                }

                /* Feature Highlights in panel */
                .panel-features {
                    display: flex;
                    flex-direction: column;
                    gap: 0.75rem;
                    position: relative;
                    z-index: 1;
                }

                .panel-feature {
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                    font-size: var(--font-size-sm);
                    color: var(--color-text-secondary);
                }

                .panel-feature-dot {
                    width: 8px;
                    height: 8px;
                    background: var(--color-primary);
                    border-radius: 50%;
                    flex-shrink: 0;
                }

                /* Right Auth Form */
                .auth-form-area {
                    flex: 1;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 2rem;
                }

                .auth-card {
                    width: 100%;
                    max-width: 440px;
                }

                .auth-card-header {
                    margin-bottom: 2rem;
                }

                .auth-card-header h1 {
                    font-size: 1.75rem;
                    font-weight: 800;
                    margin-bottom: 0.5rem;
                }

                .auth-card-header p {
                    color: var(--color-text-secondary);
                    font-size: var(--font-size-sm);
                }

                .form-footer-row {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    margin-bottom: var(--space-6);
                }

                .form-footer-link {
                    font-size: var(--font-size-sm);
                    color: var(--color-primary);
                    font-weight: 500;
                }

                .form-footer-link:hover {
                    color: var(--color-primary-dark);
                }

                .auth-redirect {
                    text-align: center;
                    font-size: var(--font-size-sm);
                    color: var(--color-text-secondary);
                    margin-top: 1.5rem;
                }

                .auth-redirect a {
                    font-weight: 600;
                    color: var(--color-primary);
                }

                .password-wrapper {
                    position: relative;
                }

                .password-wrapper .form-input {
                    padding-right: 3rem;
                }

                .toggle-password {
                    position: absolute;
                    right: 1rem;
                    top: 50%;
                    transform: translateY(-50%);
                    background: none;
                    border: none;
                    cursor: pointer;
                    color: var(--color-text-muted);
                    font-size: 1rem;
                    line-height: 1;
                    padding: 0;
                }

                .toggle-password:hover {
                    color: var(--color-primary);
                }

                /* Responsive */
                @media (max-width: 768px) {
                    .auth-panel {
                        display: none;
                    }

                    .auth-form-area {
                        padding: 2rem 1.5rem;
                    }
                }
            </style>
        </head>

        <body>

            <div class="auth-page">

                <!-- ── Left Panel ─────────────────────────────── -->
                <aside class="auth-panel">
                    <div class="auth-panel-logo">Ace<span>Bank</span></div>

                    <div class="auth-panel-copy">
                        <p class="auth-panel-quote">Your money,<br>always within reach.</p>
                        <p class="auth-panel-sub">
                            Secure, fast, and simple banking for everyone.
                            Log in to manage your balance, send money, and track every transaction.
                        </p>
                    </div>

                    <div class="panel-features">
                        <div class="panel-feature">
                            <span class="panel-feature-dot"></span>
                            <span>Instant deposits & transfers</span>
                        </div>
                        <div class="panel-feature">
                            <span class="panel-feature-dot"></span>
                            <span>Full transaction history</span>
                        </div>
                        <div class="panel-feature">
                            <span class="panel-feature-dot"></span>
                            <span>Secured with bcrypt encryption</span>
                        </div>
                    </div>

                    <p class="auth-panel-footer">© 2026 Ace Bank. All rights reserved.</p>
                </aside>

                <!-- ── Right Form ─────────────────────────────── -->
                <main class="auth-form-area">
                    <div class="auth-card fade-in-up">

                        <div class="auth-card-header">
                            <h1>Welcome Back 👋</h1>
                            <p>Enter your credentials to access your dashboard.</p>
                        </div>

                        <!-- Error Alert -->
                        <c:if test="${not empty param.error}">
                            <div class="alert alert-error">
                                ⚠ ${param.error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/Login" method="POST" novalidate>

                            <div class="form-group">
                                <label class="form-label" for="identifier">Email or Phone Number</label>
                                <input class="form-input" type="text" id="identifier" name="identifier"
                                    value="${savedIdentifier}" placeholder="Enter your email or phone number" required
                                    autocomplete="username">
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="pass">Password</label>
                                <div class="password-wrapper">
                                    <input class="form-input" type="password" id="pass" name="password"
                                        placeholder="••••••••••" required autocomplete="current-password">
                                    <button type="button" class="toggle-password" onclick="togglePw()"
                                        aria-label="Toggle password visibility">👁</button>
                                </div>
                            </div>

                            <div class="form-footer-row">
                                <label class="checkbox-label">
                                    <input type="checkbox" name="rememberMe" id="remember" ${not empty savedAccount
                                        ? 'checked' : '' }>
                                    Remember me
                                </label>
                                <a href="${pageContext.request.contextPath}/ForgotPassword.jsp"
                                    class="form-footer-link">Forgot password?</a>
                            </div>

                            <button type="submit" class="btn btn-primary btn-full"
                                style="padding: 0.85rem; font-size: 1rem;">
                                Login to Account
                            </button>

                        </form>

                        <p class="auth-redirect">
                            New to Ace Bank? <a href="${pageContext.request.contextPath}/sign-up.jsp">Create an
                                account</a>
                        </p>

                    </div>
                </main>
            </div>

            <script>
                function togglePw() {
                    const input = document.getElementById('pass');
                    input.type = input.type === 'password' ? 'text' : 'password';
                }
            </script>

        </body>

        </html>