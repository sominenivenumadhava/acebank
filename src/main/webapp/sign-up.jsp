<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Create your free Ace Bank account in under 2 minutes.">
        <title>Create Account | Ace Bank</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
        <style>
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
                background: linear-gradient(160deg, #E8FDF5 0%, #EEF2FF 100%);
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
                background: radial-gradient(circle, rgba(156, 232, 201, 0.2) 0%, transparent 70%);
                top: -60px;
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
                background: var(--color-accent-dark);
                border-radius: 50%;
                flex-shrink: 0;
            }

            /* Progress Indicator */
            .form-progress {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                margin-bottom: 2rem;
            }

            .progress-step {
                width: 28px;
                height: 28px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: var(--font-size-xs);
                font-weight: 700;
            }

            .progress-step.active {
                background: var(--color-primary);
                color: #fff;
            }

            .progress-step.inactive {
                background: var(--color-border);
                color: var(--color-text-muted);
            }

            .progress-line {
                flex: 1;
                height: 2px;
                background: var(--color-border);
            }

            /* Right Form */
            .auth-form-area {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2.5rem 2rem;
            }

            .auth-card {
                width: 100%;
                max-width: 520px;
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

            /* Validation Messages */
            .field-hint {
                font-size: var(--font-size-xs);
                color: var(--color-text-muted);
                margin-top: 0.25rem;
            }

            .field-error {
                font-size: var(--font-size-xs);
                color: var(--color-danger-dark);
                margin-top: 0.25rem;
                display: none;
            }

            .form-input.invalid {
                border-color: var(--color-danger-dark);
            }

            .form-input.valid {
                border-color: var(--color-accent-dark);
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

            /* Password Strength */
            .pw-strength {
                margin-top: 0.5rem;
            }

            .pw-strength-bar {
                height: 3px;
                border-radius: var(--radius-full);
                background: var(--color-border);
                overflow: hidden;
            }

            .pw-strength-fill {
                height: 100%;
                border-radius: var(--radius-full);
                transition: width 0.3s ease, background-color 0.3s ease;
                width: 0%;
            }

            .pw-strength-label {
                font-size: var(--font-size-xs);
                color: var(--color-text-muted);
                margin-top: 0.25rem;
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

            .terms-note {
                text-align: center;
                font-size: var(--font-size-xs);
                color: var(--color-text-muted);
                margin-top: 1rem;
                line-height: 1.6;
            }

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
                    <p class="auth-panel-quote">Start your<br>financial journey<br>today.</p>
                    <p class="auth-panel-sub">
                        Create your free account in under 2 minutes.
                        No paperwork, no queues — just simple, secure banking.
                    </p>
                </div>

                <div class="panel-features">
                    <div class="panel-feature">
                        <span class="panel-feature-dot"></span>
                        <span>Unique account number via email or SMS</span>
                    </div>
                    <div class="panel-feature">
                        <span class="panel-feature-dot"></span>
                        <span>Zero account opening fees</span>
                    </div>
                    <div class="panel-feature">
                        <span class="panel-feature-dot"></span>
                        <span>Instant access after sign-up</span>
                    </div>
                </div>

                <p class="auth-panel-footer">© 2026 Ace Bank. All rights reserved.</p>
            </aside>

            <!-- ── Right Form ─────────────────────────────── -->
            <main class="auth-form-area">
                <div class="auth-card fade-in-up">

                    <div class="auth-card-header">
                        <h1>Create Account ✨</h1>
                        <p>Join thousands of users managing their money smarter.</p>
                    </div>

                    <% if (request.getParameter("error") !=null) { %>
                        <div
                            style="background-color: var(--color-danger-light); color: var(--color-danger-dark); border: 1px solid var(--color-danger); padding: 1rem; border-radius: var(--radius-md); margin-bottom: 1.5rem; text-align: center; font-size: var(--font-size-sm); font-weight: 600;">
                            ⚠️ <%= request.getParameter("error").replace("+", " " ) %>
                        </div>
                        <% } %>

                            <form action="${pageContext.request.contextPath}/signup" method="POST" id="signup-form"
                                novalidate>

                                <div class="form-row">
                                    <div class="form-group">
                                        <label class="form-label" for="firstName">First Name</label>
                                        <input class="form-input" type="text" name="firstName" id="firstName"
                                            placeholder="e.g. Alex" required autocomplete="given-name">
                                        <span class="field-error" id="err-firstName">Please enter your first
                                            name.</span>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label" for="lastName">Last Name</label>
                                        <input class="form-input" type="text" name="lastName" id="lastName"
                                            placeholder="e.g. Kumar" required autocomplete="family-name">
                                        <span class="field-error" id="err-lastName">Please enter your last name.</span>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="aadharNumber">Aadhar Number</label>
                                    <input class="form-input" type="text" name="aadharNumber" id="aadharNumber"
                                        placeholder="12-digit Aadhar number" maxlength="12" inputmode="numeric"
                                        pattern="[0-9]{12}" required>
                                    <span class="field-hint">Must be exactly 12 digits, numbers only.</span>
                                    <span class="field-error" id="err-aadhar">Please enter a valid 12-digit Aadhar
                                        number.</span>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="identifier">Email or Phone Number</label>
                                    <input class="form-input" type="text" name="identifier" id="identifier"
                                        placeholder="you@example.com or 9876543210" required autocomplete="username">
                                    <span class="field-hint">Your account number will be sent here.</span>
                                    <span class="field-error" id="err-identifier">Please enter a valid email or phone
                                        number.</span>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="password">Password</label>
                                    <div class="password-wrapper">
                                        <input class="form-input" type="password" name="password" id="password"
                                            placeholder="Min. 10 characters" required minlength="10"
                                            autocomplete="new-password" oninput="checkStrength(this.value)">
                                        <button type="button" class="toggle-password" onclick="togglePw()"
                                            aria-label="Toggle password">👁</button>
                                    </div>
                                    <div class="pw-strength">
                                        <div class="pw-strength-bar">
                                            <div class="pw-strength-fill" id="pw-fill"></div>
                                        </div>
                                        <p class="pw-strength-label" id="pw-label">Enter a password to check strength
                                        </p>
                                    </div>
                                    <span class="field-error" id="err-password">Password must be at least 10
                                        characters.</span>
                                </div>

                                <div class="form-group" style="margin-top: 1rem;">
                                    <label class="form-label" for="transactionPin">Transaction PIN</label>
                                    <input class="form-input" type="password" name="transactionPin" id="transactionPin"
                                        placeholder="4-Digit PIN" maxlength="4" pattern="\d{4}"
                                        style="letter-spacing:0.5rem;" required>
                                    <span class="field-hint">Used for sending money and withdrawals.</span>
                                    <span class="field-error" id="err-transactionPin">Please enter a valid 4-digit
                                        PIN.</span>
                                </div>

                                <button type="submit" id="submit-btn" class="btn btn-primary btn-full"
                                    style="padding: 0.85rem; font-size: 1rem; margin-top: 0.5rem;">
                                    Create My Account
                                </button>

                            </form>

                            <p class="terms-note">
                                By creating an account you agree to our <a href="#"
                                    style="color:var(--color-primary);">Terms of
                                    Service</a> and <a href="#" style="color:var(--color-primary);">Privacy Policy</a>.
                            </p>

                            <p class="auth-redirect">
                                Already have an account? <a href="${pageContext.request.contextPath}/login.jsp">Log
                                    in</a>
                            </p>

                </div>
            </main>
        </div>

        <script>
            function togglePw() {
                const input = document.getElementById('password');
                input.type = input.type === 'password' ? 'text' : 'password';
            }

            function checkStrength(pw) {
                const fill = document.getElementById('pw-fill');
                const label = document.getElementById('pw-label');
                let score = 0;
                if (pw.length >= 10) score++;
                if (/[A-Z]/.test(pw)) score++;
                if (/[0-9]/.test(pw)) score++;
                if (/[^A-Za-z0-9]/.test(pw)) score++;

                const levels = [
                    { pct: '0%', color: '#E8ECF4', text: 'Enter a password' },
                    { pct: '25%', color: '#F9A8A8', text: 'Weak' },
                    { pct: '50%', color: '#FDDBA0', text: 'Fair' },
                    { pct: '75%', color: '#7C9EFF', text: 'Good' },
                    { pct: '100%', color: '#9CE8C9', text: 'Strong 🎉' },
                ];

                const lvl = levels[score] || levels[0];
                fill.style.width = lvl.pct;
                fill.style.backgroundColor = lvl.color;
                label.textContent = pw.length === 0 ? 'Enter a password to check strength' : lvl.text;
            }

            // Client-side validation
            document.getElementById('signup-form').addEventListener('submit', function (e) {
                let valid = true;
                const show = (id) => { document.getElementById(id).style.display = 'block'; };
                const hide = (id) => { document.getElementById(id).style.display = 'none'; };

                const firstName = document.getElementById('firstName').value.trim();
                const lastName = document.getElementById('lastName').value.trim();
                const aadhar = document.getElementById('aadharNumber').value.trim();
                const identifier = document.getElementById('identifier').value.trim();
                const password = document.getElementById('password').value;
                const transactionPin = document.getElementById('transactionPin').value.trim();

                if (!firstName) { show('err-firstName'); valid = false; } else { hide('err-firstName'); }
                if (!lastName) { show('err-lastName'); valid = false; } else { hide('err-lastName'); }

                if (/^\d{12}$/.test(aadhar)) { hide('err-aadhar'); }
                else { show('err-aadhar'); valid = false; }

                // Check if email or valid phone
                const isEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(identifier);
                const isPhone = /^\d{10,15}$/.test(identifier);
                if (isEmail || isPhone) { hide('err-identifier'); }
                else { show('err-identifier'); valid = false; }

                if (password.length >= 10) { hide('err-password'); }
                else { show('err-password'); valid = false; }

                if (/^\d{4}$/.test(transactionPin)) { hide('err-transactionPin'); }
                else { show('err-transactionPin'); valid = false; }

                if (!valid) e.preventDefault();
            });
        </script>

    </body>

    </html>