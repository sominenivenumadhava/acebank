<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Ace Bank – Banking made easy. Open an account in minutes and manage your money with ease.">
    <title>Ace Bank | Modern Banking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <style>
        /* ── Landing Page Specific Styles ── */

        /* Hero Section */
        .hero {
            padding: 7rem 0 5rem;
            background: linear-gradient(160deg, #F0F4FF 0%, #F9FAFB 55%, #EDFDF6 100%);
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            width: 600px; height: 600px;
            background: radial-gradient(circle, rgba(124,158,255,0.12) 0%, transparent 70%);
            top: -100px; right: -100px;
            pointer-events: none;
        }

        .hero::after {
            content: '';
            position: absolute;
            width: 400px; height: 400px;
            background: radial-gradient(circle, rgba(156,232,201,0.15) 0%, transparent 70%);
            bottom: -80px; left: 10%;
            pointer-events: none;
        }

        .hero-inner {
            display: grid;
            grid-template-columns: 1fr 1fr;
            align-items: center;
            gap: 4rem;
            position: relative;
            z-index: 1;
        }

        .hero-tag {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: var(--color-primary-light);
            color: var(--color-primary-dark);
            border: 1px solid rgba(124,158,255,0.3);
            padding: 0.35rem 1rem;
            border-radius: var(--radius-full);
            font-size: var(--font-size-xs);
            font-weight: 600;
            letter-spacing: 0.05em;
            text-transform: uppercase;
            margin-bottom: 1.5rem;
        }

        .hero-tag::before {
            content: '';
            width: 7px; height: 7px;
            background: var(--color-primary);
            border-radius: 50%;
        }

        .hero-title {
            font-size: var(--font-size-hero);
            font-weight: 800;
            line-height: 1.1;
            letter-spacing: -1.5px;
            margin-bottom: 1.5rem;
            color: var(--color-text-primary);
        }

        .hero-title .highlight {
            color: var(--color-primary);
            position: relative;
        }

        .hero-description {
            font-size: var(--font-size-md);
            color: var(--color-text-secondary);
            line-height: 1.7;
            margin-bottom: 2.5rem;
            max-width: 460px;
        }

        .hero-cta {
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .hero-cta .btn {
            padding: 0.85rem 2rem;
            font-size: 1rem;
            border-radius: var(--radius-lg);
        }

        .hero-stats {
            display: flex;
            gap: 2.5rem;
            margin-top: 3rem;
            padding-top: 2rem;
            border-top: 1px solid var(--color-border);
        }

        .hero-stat-value {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--color-text-primary);
            line-height: 1;
        }

        .hero-stat-label {
            font-size: var(--font-size-xs);
            color: var(--color-text-muted);
            margin-top: 0.25rem;
        }

        /* Hero Visual */
        .hero-visual {
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .mock-card {
            background: #fff;
            border: 1px solid var(--color-border);
            border-radius: 1.5rem;
            padding: 2rem;
            box-shadow: var(--shadow-lg);
            width: 320px;
            animation: fadeInUp 0.7s ease both 0.2s;
        }

        .mock-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.75rem;
        }

        .mock-card-logo {
            font-size: 1rem;
            font-weight: 700;
            color: var(--color-text-primary);
        }

        .mock-card-logo span { color: var(--color-primary); }

        .mock-chip {
            width: 40px; height: 30px;
            background: linear-gradient(135deg, var(--color-warning), #f5c560);
            border-radius: 6px;
        }

        .mock-card-number {
            font-size: 1.05rem;
            letter-spacing: 0.2em;
            color: var(--color-text-secondary);
            margin-bottom: 1.5rem;
            font-weight: 500;
        }

        .mock-card-info {
            display: flex;
            justify-content: space-between;
            font-size: var(--font-size-sm);
        }

        .mock-card-label {
            font-size: var(--font-size-xs);
            color: var(--color-text-muted);
            text-transform: uppercase;
            letter-spacing: 0.06em;
            margin-bottom: 0.25rem;
        }

        .mock-card-value {
            font-weight: 600;
            color: var(--color-text-primary);
        }

        .mock-balance {
            background: linear-gradient(135deg, var(--color-primary-light), var(--color-accent-light));
            border-radius: 1rem;
            padding: 1.25rem;
            margin-top: 1.25rem;
            text-align: center;
            border: 1px solid var(--color-border);
        }

        .mock-balance-label {
            font-size: var(--font-size-xs);
            color: var(--color-text-muted);
            text-transform: uppercase;
            letter-spacing: 0.06em;
        }

        .mock-balance-amount {
            font-size: 1.75rem;
            font-weight: 800;
            color: var(--color-text-primary);
            margin-top: 0.25rem;
        }

        .mock-tx {
            margin-top: 1.25rem;
        }

        .mock-tx-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0.6rem 0;
            border-bottom: 1px solid var(--color-border);
            font-size: var(--font-size-sm);
        }

        .mock-tx-item:last-child { border-bottom: none; }

        .mock-tx-left { display: flex; align-items: center; gap: 0.625rem; }

        .mock-tx-icon {
            width: 30px; height: 30px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.8rem;
        }

        .mock-tx-icon.in  { background: var(--color-success-light); color: var(--color-accent-dark); }
        .mock-tx-icon.out { background: var(--color-danger-light);  color: var(--color-danger-dark); }

        .mock-tx-desc { font-weight: 500; color: var(--color-text-primary); font-size: 0.8rem; }
        .mock-tx-date { font-size: 0.7rem; color: var(--color-text-muted); }

        .mock-tx-amount { font-weight: 700; font-size: 0.85rem; }
        .mock-tx-amount.in  { color: var(--color-accent-dark); }
        .mock-tx-amount.out { color: var(--color-danger-dark); }

        /* Floating decorators */
        .deco-dot {
            position: absolute;
            border-radius: 50%;
            opacity: 0.5;
            pointer-events: none;
        }

        .deco-1 {
            width: 80px; height: 80px;
            background: var(--color-primary-light);
            border: 2px solid rgba(124,158,255,0.3);
            top: -20px; left: -20px;
            animation: fadeIn 1s ease both 0.5s;
        }

        .deco-2 {
            width: 50px; height: 50px;
            background: var(--color-accent-light);
            border: 2px solid rgba(156,232,201,0.4);
            bottom: 10px; right: -20px;
            animation: fadeIn 1s ease both 0.7s;
        }

        /* Features Section */
        .section {
            padding: 5rem 0;
        }

        .section-alt {
            background: var(--color-surface-alt);
        }

        .section-header {
            text-align: center;
            margin-bottom: 3.5rem;
        }

        .section-tag {
            display: inline-block;
            background: var(--color-primary-light);
            color: var(--color-primary-dark);
            border-radius: var(--radius-full);
            padding: 0.3rem 1rem;
            font-size: var(--font-size-xs);
            font-weight: 600;
            letter-spacing: 0.05em;
            text-transform: uppercase;
            margin-bottom: 1rem;
        }

        .section-title {
            font-size: var(--font-size-3xl);
            font-weight: 800;
            letter-spacing: -1px;
            margin-bottom: 0.75rem;
        }

        .section-sub {
            font-size: var(--font-size-md);
            color: var(--color-text-secondary);
            max-width: 520px;
            margin-inline: auto;
            line-height: 1.7;
        }

        /* Feature Cards */
        .features-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.5rem;
        }

        .feature-card {
            background: var(--color-surface);
            border: 1px solid var(--color-border);
            border-radius: var(--radius-lg);
            padding: 2rem;
            transition: all var(--transition-base);
        }

        .feature-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-md);
            border-color: var(--color-primary);
        }

        .feature-icon {
            width: 52px; height: 52px;
            border-radius: var(--radius-md);
            display: flex; align-items: center; justify-content: center;
            font-size: 1.4rem;
            margin-bottom: 1.25rem;
        }

        .icon-blue   { background: var(--color-primary-light); }
        .icon-green  { background: var(--color-success-light); }
        .icon-yellow { background: var(--color-warning-light); }
        .icon-pink   { background: var(--color-danger-light);  }

        .feature-title {
            font-size: var(--font-size-md);
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .feature-desc {
            font-size: var(--font-size-sm);
            color: var(--color-text-secondary);
            line-height: 1.65;
        }

        /* Steps Section */
        .steps-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
            position: relative;
        }

        .steps-grid::after {
            content: '';
            position: absolute;
            top: 1.75rem;
            left: calc(1/6 * 100% + 1rem);
            width: calc(2/3 * 100% - 2rem);
            height: 2px;
            background: linear-gradient(to right, var(--color-primary), var(--color-accent));
            opacity: 0.3;
        }

        .step-card {
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 1.5rem;
        }

        .step-number {
            width: 52px; height: 52px;
            background: var(--color-primary-light);
            color: var(--color-primary-dark);
            border: 2px solid rgba(124,158,255,0.3);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: var(--font-size-lg);
            font-weight: 800;
            margin-bottom: 1.25rem;
            position: relative;
            z-index: 1;
        }

        .step-title {
            font-size: var(--font-size-md);
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .step-desc {
            font-size: var(--font-size-sm);
            color: var(--color-text-secondary);
            line-height: 1.65;
        }

        /* CTA Banner */
        .cta-banner {
            background: linear-gradient(135deg, var(--color-primary-light) 0%, var(--color-accent-light) 100%);
            border: 1px solid var(--color-border);
            border-radius: 2rem;
            padding: 4rem;
            text-align: center;
            margin: 0 auto;
            max-width: 700px;
        }

        .cta-banner h2 {
            font-size: var(--font-size-3xl);
            font-weight: 800;
            margin-bottom: 1rem;
            letter-spacing: -0.5px;
        }

        .cta-banner p {
            color: var(--color-text-secondary);
            margin-bottom: 2rem;
            font-size: var(--font-size-md);
        }

        /* Footer */
        .site-footer {
            border-top: 1px solid var(--color-border);
            padding: 1.75rem 0;
            background: var(--color-surface);
        }

        .footer-inner {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .footer-copy {
            font-size: var(--font-size-sm);
            color: var(--color-text-muted);
        }

        .footer-tagline {
            font-size: var(--font-size-xs);
            color: var(--color-text-muted);
        }

        /* Responsive */
        @media (max-width: 900px) {
            .hero-inner       { grid-template-columns: 1fr; text-align: center; }
            .hero-description { margin-inline: auto; }
            .hero-cta         { justify-content: center; }
            .hero-stats       { justify-content: center; }
            .hero-visual      { display: none; }
            .features-grid    { grid-template-columns: 1fr; }
            .steps-grid       { grid-template-columns: 1fr; }
            .steps-grid::after { display: none; }
            .cta-banner       { padding: 2.5rem 1.5rem; }
        }
    </style>
</head>
<body>

<!-- ── Header ───────────────────────────────────────────── -->
<header class="site-header">
    <div class="container">
        <div class="header-inner">
            <a href="${pageContext.request.contextPath}/" class="logo">Ace<span>Bank</span></a>
            <nav class="nav-links">
                <a href="${pageContext.request.contextPath}/login.jsp">Login</a>
                <a href="${pageContext.request.contextPath}/sign-up.jsp" class="btn btn-primary btn-sm">Open Account</a>
            </nav>
        </div>
    </div>
</header>

<!-- ── Hero ─────────────────────────────────────────────── -->
<section class="hero">
    <div class="container">
        <div class="hero-inner">
            <!-- Left: Copy -->
            <div class="fade-in-up">
                <div class="hero-tag">✦ Trusted by 2M+ Users</div>
                <h1 class="hero-title">
                    Banking Made<br><span class="highlight">Easy &amp; Smart</span>
                </h1>
                <p class="hero-description">
                    Join over 40,000 people who open an Ace Bank account every week.
                    Manage, send, and save your money — all in one beautifully simple place.
                </p>
                <div class="hero-cta">
                    <a href="${pageContext.request.contextPath}/sign-up.jsp" class="btn btn-primary">Open Free Account</a>
                    <a href="#features" class="btn btn-secondary">Explore Features</a>
                </div>
                <div class="hero-stats">
                    <div>
                        <div class="hero-stat-value">2M+</div>
                        <div class="hero-stat-label">Active Users</div>
                    </div>
                    <div>
                        <div class="hero-stat-value">₹500Cr+</div>
                        <div class="hero-stat-label">Transactions</div>
                    </div>
                    <div>
                        <div class="hero-stat-value">4.9 ★</div>
                        <div class="hero-stat-label">User Rating</div>
                    </div>
                </div>
            </div>

            <!-- Right: Mock Card Visual -->
            <div class="hero-visual">
                <span class="deco-dot deco-1"></span>
                <span class="deco-dot deco-2"></span>
                <div class="mock-card">
                    <div class="mock-card-header">
                        <div class="mock-card-logo">Ace<span>Bank</span></div>
                        <div class="mock-chip"></div>
                    </div>
                    <div class="mock-card-number">•••• •••• •••• 2048</div>
                    <div class="mock-card-info">
                        <div>
                            <div class="mock-card-label">Card Holder</div>
                            <div class="mock-card-value">Alex Kumar</div>
                        </div>
                        <div>
                            <div class="mock-card-label">Valid Thru</div>
                            <div class="mock-card-value">12/28</div>
                        </div>
                    </div>

                    <div class="mock-balance">
                        <div class="mock-balance-label">Available Balance</div>
                        <div class="mock-balance-amount">₹ 1,24,800</div>
                    </div>

                    <div class="mock-tx">
                        <div class="mock-tx-item">
                            <div class="mock-tx-left">
                                <div class="mock-tx-icon in">↑</div>
                                <div>
                                    <div class="mock-tx-desc">Salary Credit</div>
                                    <div class="mock-tx-date">Today, 10:32 AM</div>
                                </div>
                            </div>
                            <div class="mock-tx-amount in">+₹50,000</div>
                        </div>
                        <div class="mock-tx-item">
                            <div class="mock-tx-left">
                                <div class="mock-tx-icon out">↓</div>
                                <div>
                                    <div class="mock-tx-desc">Rent Transfer</div>
                                    <div class="mock-tx-date">Yesterday</div>
                                </div>
                            </div>
                            <div class="mock-tx-amount out">-₹18,000</div>
                        </div>
                        <div class="mock-tx-item">
                            <div class="mock-tx-left">
                                <div class="mock-tx-icon in">↑</div>
                                <div>
                                    <div class="mock-tx-desc">Refund</div>
                                    <div class="mock-tx-date">Feb 24</div>
                                </div>
                            </div>
                            <div class="mock-tx-amount in">+₹2,400</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ── Features ──────────────────────────────────────────── -->
<section class="section" id="features">
    <div class="container">
        <div class="section-header">
            <div class="section-tag">✦ Features</div>
            <h2 class="section-title">Everything You Need</h2>
            <p class="section-sub">Powerful banking tools designed to make your financial life simpler and smarter.</p>
        </div>
        <div class="features-grid">
            <div class="feature-card fade-in-up animate-delay-1">
                <div class="feature-icon icon-blue">💸</div>
                <h3 class="feature-title">Instant Transfers</h3>
                <p class="feature-desc">Send money to any Ace Bank account instantly — no delays, no hidden fees. Real-time processing 24/7.</p>
            </div>
            <div class="feature-card fade-in-up animate-delay-2">
                <div class="feature-icon icon-green">📊</div>
                <h3 class="feature-title">Transaction History</h3>
                <p class="feature-desc">Full visibility into every deposit, withdrawal, and transfer. Track your spending with ease.</p>
            </div>
            <div class="feature-card fade-in-up animate-delay-3">
                <div class="feature-icon icon-yellow">🔒</div>
                <h3 class="feature-title">Bank-Grade Security</h3>
                <p class="feature-desc">Your account is protected with bcrypt password hashing, session management, and secure HTTPS.</p>
            </div>
            <div class="feature-card fade-in-up animate-delay-1">
                <div class="feature-icon icon-pink">📱</div>
                <h3 class="feature-title">Fully Responsive</h3>
                <p class="feature-desc">Works beautifully across all devices — desktop, tablet, and mobile. Bank on the go.</p>
            </div>
            <div class="feature-card fade-in-up animate-delay-2">
                <div class="feature-icon icon-blue">⚡</div>
                <h3 class="feature-title">Quick Deposit</h3>
                <p class="feature-desc">Add funds to your account in seconds. One input, one click — your balance updates instantly.</p>
            </div>
            <div class="feature-card fade-in-up animate-delay-3">
                <div class="feature-icon icon-green">✉️</div>
                <h3 class="feature-title">Email Notifications</h3>
                <p class="feature-desc">Get your account number by email on sign-up. Password reset via OTP so you're never locked out.</p>
            </div>
        </div>
    </div>
</section>

<!-- ── How It Works ──────────────────────────────────────── -->
<section class="section section-alt">
    <div class="container">
        <div class="section-header">
            <div class="section-tag">✦ Getting Started</div>
            <h2 class="section-title">Up &amp; Running in 3 Steps</h2>
            <p class="section-sub">Open your account in under two minutes — no paperwork, no queues.</p>
        </div>
        <div class="steps-grid">
            <div class="step-card fade-in-up animate-delay-1">
                <div class="step-number">1</div>
                <h3 class="step-title">Create Account</h3>
                <p class="step-desc">Fill in your name, Aadhar number, and email. Set a strong password and submit — it takes 30 seconds.</p>
            </div>
            <div class="step-card fade-in-up animate-delay-2">
                <div class="step-number">2</div>
                <h3 class="step-title">Receive Account No.</h3>
                <p class="step-desc">Your unique account number is generated instantly and emailed to you for safe keeping.</p>
            </div>
            <div class="step-card fade-in-up animate-delay-3">
                <div class="step-number">3</div>
                <h3 class="step-title">Start Banking</h3>
                <p class="step-desc">Log in with your account number and password. Deposit, transfer, or withdraw — you're in control.</p>
            </div>
        </div>
    </div>
</section>

<!-- ── CTA ───────────────────────────────────────────────── -->
<section class="section">
    <div class="container">
        <div class="cta-banner fade-in-up">
            <h2>Ready to Get Started?</h2>
            <p>Join thousands of users already managing their money smarter with Ace Bank.</p>
            <div style="display:flex; gap:1rem; justify-content:center; flex-wrap:wrap;">
                <a href="${pageContext.request.contextPath}/sign-up.jsp" class="btn btn-primary" style="padding: 0.85rem 2rem; font-size: 1rem;">Open Free Account</a>
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-secondary" style="padding: 0.85rem 2rem; font-size: 1rem;">Login to Dashboard</a>
            </div>
        </div>
    </div>
</section>

<!-- ── Footer ────────────────────────────────────────────── -->
<footer class="site-footer">
    <div class="container">
        <div class="footer-inner">
            <div class="logo" style="font-size:1rem;">Ace<span>Bank</span></div>
            <p class="footer-copy">© 2026 Ace Bank. All rights reserved.</p>
            <p class="footer-tagline">Built for simplicity. Secured for trust.</p>
        </div>
    </div>
</footer>

</body>
</html>