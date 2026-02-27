<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Failed | Ace Bank</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
        <style>
            body {
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                background: linear-gradient(160deg, #FFF0F0 0%, #F9FAFB 100%);
            }

            .fail-wrapper {
                text-align: center;
                max-width: 440px;
                padding: 1rem;
            }

            .fail-icon {
                font-size: 4rem;
                margin-bottom: 1.25rem;
                animation: fadeInUp 0.5s ease both;
            }

            .fail-title {
                font-size: 1.5rem;
                font-weight: 800;
                margin-bottom: 0.75rem;
            }

            .fail-message {
                color: var(--color-text-secondary);
                font-size: var(--font-size-sm);
                line-height: 1.7;
                margin-bottom: 2rem;
            }

            .fail-actions {
                display: flex;
                flex-direction: column;
                gap: 0.75rem;
                align-items: center;
            }

            .hint-box {
                background: var(--color-warning-light);
                border: 1px solid var(--color-warning);
                border-radius: var(--radius-md);
                padding: 1rem 1.25rem;
                font-size: var(--font-size-sm);
                color: #8a6400;
                text-align: left;
                margin-bottom: 1.5rem;
            }

            .hint-box ul {
                margin-top: 0.5rem;
                padding-left: 1.2rem;
                list-style: disc;
            }

            .hint-box li {
                margin-bottom: 0.25rem;
            }
        </style>
    </head>

    <body>
        <div class="fail-wrapper fade-in-up">
            <div style="margin-bottom:1.5rem;">
                <a href="${pageContext.request.contextPath}/"
                    style="font-size:1.25rem; font-weight:700; color:var(--color-text-primary); text-decoration:none;">
                    Ace<span style="color:var(--color-primary);">Bank</span>
                </a>
            </div>

            <div class="fail-icon">🔐</div>

            <h1 class="fail-title">Login Failed</h1>
            <p class="fail-message">
                We couldn't verify your credentials. Please check your account number and password and try again.
            </p>

            <div class="hint-box">
                <strong>Common reasons for login failure:</strong>
                <ul>
                    <li>Incorrect account number or password</li>
                    <li>Caps Lock is on — passwords are case-sensitive</li>
                    <li>Account may not exist yet — try signing up</li>
                </ul>
            </div>

            <div class="fail-actions">
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary"
                    style="width:100%; max-width:280px;">
                    Try Again
                </a>
                <a href="${pageContext.request.contextPath}/ForgotPassword.jsp" class="btn btn-ghost btn-sm">
                    Forgot your password?
                </a>
                <a href="${pageContext.request.contextPath}/sign-up.jsp" class="btn btn-ghost btn-sm">
                    Don't have an account? Sign up
                </a>
            </div>
        </div>
    </body>

    </html>