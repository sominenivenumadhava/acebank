<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${errorCode} ${errorTitle} | Ace Bank</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
        <style>
            body {
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                background: linear-gradient(160deg, #F0F4FF 0%, #F9FAFB 100%);
            }

            .error-wrapper {
                text-align: center;
                max-width: 480px;
                padding: 1rem;
            }

            .error-code-badge {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 100px;
                height: 100px;
                background: var(--color-danger-light);
                border: 2px solid var(--color-danger);
                border-radius: 50%;
                font-size: 2rem;
                font-weight: 900;
                color: var(--color-danger-dark);
                margin: 0 auto 1.5rem;
            }

            .error-title {
                font-size: 1.5rem;
                font-weight: 800;
                margin-bottom: 0.75rem;
            }

            .error-message {
                color: var(--color-text-secondary);
                font-size: var(--font-size-sm);
                line-height: 1.7;
                margin-bottom: 2rem;
            }

            .error-actions {
                display: flex;
                gap: 1rem;
                justify-content: center;
            }
        </style>
    </head>

    <body>
        <div class="error-wrapper fade-in-up">
            <div style="margin-bottom:1rem;">
                <a href="${pageContext.request.contextPath}/" class="logo"
                    style="font-size:1.25rem; font-weight:700; color:var(--color-text-primary); text-decoration:none;">
                    Ace<span style="color:var(--color-primary);">Bank</span>
                </a>
            </div>

            <div class="error-code-badge">${errorCode}</div>

            <h1 class="error-title">${errorTitle}</h1>
            <p class="error-message">${errorMessage}</p>

            <div class="error-actions">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Return to Dashboard</a>
                <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Go Home</a>
            </div>
        </div>
    </body>

    </html>