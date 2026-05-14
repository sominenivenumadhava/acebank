<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Change Password | Ace Bank</title>
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

                .change-card {
                    background: var(--color-surface);
                    border: 1px solid var(--color-border);
                    border-radius: var(--radius-xl);
                    box-shadow: var(--shadow-md);
                    padding: 2.5rem;
                    width: 100%;
                    max-width: 440px;
                }

                .change-card-logo {
                    font-size: 1.25rem;
                    font-weight: 700;
                    color: var(--color-text-primary);
                    margin-bottom: 2rem;
                    display: block;
                    text-decoration: none;
                }

                .change-card-logo span {
                    color: var(--color-primary);
                }

                .step-icon {
                    width: 64px;
                    height: 64px;
                    background: var(--color-accent-light);
                    border: 2px solid rgba(156, 232, 201, 0.4);
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.75rem;
                    margin-bottom: 1.5rem;
                }

                .change-title {
                    font-size: 1.5rem;
                    font-weight: 800;
                    margin-bottom: 0.5rem;
                }

                .change-sub {
                    color: var(--color-text-secondary);
                    font-size: var(--font-size-sm);
                    margin-bottom: 2rem;
                    line-height: 1.65;
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

                .pw-strength {
                    margin-top: 0.5rem;
                }

                .pw-strength-bar {
                    height: 3px;
                    border-radius: var(--radius-full);
                    background: var(--color-border);
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

            <div class="change-card fade-in-up">
                <a href="${pageContext.request.contextPath}/home" class="change-card-logo">Ace<span>Bank</span></a>

                <div class="step-icon">🔒</div>

                <h1 class="change-title">Change Password</h1>
                <p class="change-sub">Choose a strong new password to keep your account secure.</p>

                <!-- Success -->
                <c:if test="${not empty param.success}">
                    <div class="alert alert-success" style="margin-bottom:1.5rem;">
                        ✓ Password changed successfully! <a href="${pageContext.request.contextPath}/login.jsp">Login
                            again</a>
                    </div>
                </c:if>

                <!-- Error -->
                <c:if test="${not empty param.error}">
                    <div class="alert alert-error" style="margin-bottom:1.5rem;">
                        ⚠ ${param.error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/changePassword" method="POST" id="change-form"
                    novalidate>

                    <div class="form-group">
                        <label class="form-label" for="oldPassword">Current Password</label>
                        <div class="password-wrapper">
                            <input class="form-input" type="password" id="oldPassword" name="oldPassword"
                                placeholder="••••••••••" required autocomplete="current-password">
                            <button type="button" class="toggle-password" onclick="togglePw('oldPassword')"
                                aria-label="Toggle">👁</button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="newPassword">New Password</label>
                        <div class="password-wrapper">
                            <input class="form-input" type="password" id="newPassword" name="newPassword"
                                placeholder="Min. 10 characters" required minlength="10" autocomplete="new-password"
                                oninput="checkStrength(this.value)">
                            <button type="button" class="toggle-password" onclick="togglePw('newPassword')"
                                aria-label="Toggle">👁</button>
                        </div>
                        <div class="pw-strength">
                            <div class="pw-strength-bar">
                                <div class="pw-strength-fill" id="pw-fill"></div>
                            </div>
                            <p class="pw-strength-label" id="pw-label">Enter a password to check strength</p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="confirmPassword">Confirm New Password</label>
                        <div class="password-wrapper">
                            <input class="form-input" type="password" id="confirmPassword" name="confirmPassword"
                                placeholder="Re-enter new password" required autocomplete="new-password">
                            <button type="button" class="toggle-password" onclick="togglePw('confirmPassword')"
                                aria-label="Toggle">👁</button>
                        </div>
                        <span style="font-size:var(--font-size-xs); color:var(--color-danger-dark); display:none;"
                            id="match-err">Passwords do not match.</span>
                    </div>

                    <button type="submit" class="btn btn-primary btn-full" style="padding: 0.8rem; font-size: 1rem;">
                        Update Password
                    </button>

                </form>

                <a href="${pageContext.request.contextPath}/home" class="back-link">← Back to Dashboard</a>
            </div>

            <script>
                function togglePw(id) {
                    const el = document.getElementById(id);
                    el.type = el.type === 'password' ? 'text' : 'password';
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

                document.getElementById('change-form').addEventListener('submit', function (e) {
                    const np = document.getElementById('newPassword').value;
                    const cp = document.getElementById('confirmPassword').value;
                    const errEl = document.getElementById('match-err');
                    if (np !== cp) {
                        errEl.style.display = 'block';
                        e.preventDefault();
                    } else {
                        errEl.style.display = 'none';
                    }
                });
            </script>

        </body>

        </html>