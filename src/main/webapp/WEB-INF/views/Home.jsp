<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Dashboard | ACE Bank</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
                rel="stylesheet">
            <style>
                *,
                *::before,
                *::after {
                    box-sizing: border-box;
                    margin: 0;
                    padding: 0;
                }

                :root {
                    --bg: #0a0d14;
                    --bg2: #0f1320;
                    --card: #131725;
                    --card2: #1a1f2e;
                    --border: rgba(255, 255, 255, 0.07);
                    --border2: rgba(255, 255, 255, 0.12);
                    --text: #f0f2ff;
                    --muted: #6b7280;
                    --muted2: #9ca3af;
                    --blue: #6366f1;
                    --blue-soft: #818cf8;
                    --green: #10b981;
                    --red: #ef4444;
                    --amber: #f59e0b;
                    --purple: #a855f7;
                    --glow-blue: rgba(99, 102, 241, 0.35);
                    --glow-green: rgba(16, 185, 129, 0.25);
                    --sidebar-w: 240px;
                    --radius: 14px;
                    --radius-sm: 8px;
                    --transition: all 0.22s ease;
                }

                html,
                body {
                    height: 100%;
                    font-family: 'Inter', sans-serif;
                    background: var(--bg);
                    color: var(--text);
                    font-size: 15px;
                    line-height: 1.6;
                }

                /* ── App Shell ──────────────────────────────────────────── */
                .shell {
                    display: flex;
                    min-height: 100vh;
                }

                /* ── Sidebar ────────────────────────────────────────────── */
                .sidebar {
                    width: var(--sidebar-w);
                    flex-shrink: 0;
                    background: var(--bg2);
                    border-right: 1px solid var(--border);
                    display: flex;
                    flex-direction: column;
                    position: fixed;
                    top: 0;
                    left: 0;
                    height: 100vh;
                    z-index: 50;
                    padding: 1.5rem 1rem;
                }

                .sidebar-logo {
                    display: flex;
                    align-items: center;
                    gap: 0.625rem;
                    padding: 0.5rem 0.75rem;
                    margin-bottom: 2rem;
                    text-decoration: none;
                }

                .sidebar-logo .logo-icon {
                    width: 34px;
                    height: 34px;
                    background: linear-gradient(135deg, var(--blue), var(--purple));
                    border-radius: 10px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1rem;
                    box-shadow: 0 4px 14px var(--glow-blue);
                }

                .sidebar-logo .logo-name {
                    font-size: 1.1rem;
                    font-weight: 800;
                    letter-spacing: -0.3px;
                    color: var(--text);
                }

                .sidebar-logo .logo-name span {
                    color: var(--blue-soft);
                }

                .sidebar-nav {
                    flex: 1;
                    display: flex;
                    flex-direction: column;
                    gap: 0.25rem;
                }

                .nav-label {
                    font-size: 0.65rem;
                    font-weight: 600;
                    letter-spacing: 0.1em;
                    text-transform: uppercase;
                    color: var(--muted);
                    padding: 0.75rem 0.75rem 0.25rem;
                    margin-top: 0.5rem;
                }

                .nav-item {
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                    padding: 0.625rem 0.875rem;
                    border-radius: var(--radius-sm);
                    color: var(--muted2);
                    text-decoration: none;
                    font-size: 0.875rem;
                    font-weight: 500;
                    transition: var(--transition);
                    cursor: pointer;
                    border: none;
                    background: none;
                    width: 100%;
                    text-align: left;
                }

                .nav-item:hover {
                    background: rgba(255, 255, 255, 0.04);
                    color: var(--text);
                }

                .nav-item.active {
                    background: rgba(99, 102, 241, 0.15);
                    color: var(--blue-soft);
                }

                .nav-item .nav-icon {
                    width: 28px;
                    height: 28px;
                    border-radius: 7px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 0.875rem;
                    flex-shrink: 0;
                }

                .sidebar-footer {
                    border-top: 1px solid var(--border);
                    padding-top: 1rem;
                }

                .user-chip {
                    display: flex;
                    align-items: center;
                    gap: 0.625rem;
                    padding: 0.625rem 0.75rem;
                    border-radius: var(--radius-sm);
                    background: rgba(255, 255, 255, 0.04);
                }

                .user-avatar {
                    width: 34px;
                    height: 34px;
                    border-radius: 50%;
                    background: linear-gradient(135deg, var(--blue), var(--purple));
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 0.8rem;
                    font-weight: 700;
                    color: #fff;
                    flex-shrink: 0;
                }

                .user-name {
                    font-size: 0.8rem;
                    font-weight: 600;
                }

                .user-role {
                    font-size: 0.7rem;
                    color: var(--muted);
                }

                /* ── Main Content ───────────────────────────────────────── */
                .main {
                    margin-left: var(--sidebar-w);
                    flex: 1;
                    min-width: 0;
                    display: flex;
                    flex-direction: column;
                }

                .topbar {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    padding: 1.125rem 2rem;
                    border-bottom: 1px solid var(--border);
                    background: rgba(10, 13, 20, 0.8);
                    backdrop-filter: blur(12px);
                    position: sticky;
                    top: 0;
                    z-index: 40;
                }

                .topbar-title h2 {
                    font-size: 1.05rem;
                    font-weight: 700;
                }

                .topbar-title p {
                    font-size: 0.75rem;
                    color: var(--muted);
                }

                .topbar-actions {
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                }

                .icon-btn {
                    width: 36px;
                    height: 36px;
                    border-radius: 9px;
                    background: var(--card2);
                    border: 1px solid var(--border);
                    color: var(--muted2);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    cursor: pointer;
                    transition: var(--transition);
                    font-size: 0.875rem;
                    text-decoration: none;
                }

                .icon-btn:hover {
                    border-color: var(--border2);
                    color: var(--text);
                }

                /* ── Page Body ──────────────────────────────────────────── */
                .page-body {
                    padding: 2rem;
                    display: flex;
                    flex-direction: column;
                    gap: 1.75rem;
                }

                /* ── Hero Balance Row ───────────────────────────────────── */
                .hero-row {
                    display: grid;
                    grid-template-columns: 1fr 1fr 1fr;
                    gap: 1.25rem;
                }

                /* Hero Balance Card */
                .hero-balance {
                    grid-column: span 2;
                    position: relative;
                    border-radius: 20px;
                    overflow: hidden;
                    padding: 2rem 2.25rem;
                    background: linear-gradient(135deg, #1e1b4b 0%, #1e2a5e 50%, #0f1c3f 100%);
                    border: 1px solid rgba(99, 102, 241, 0.3);
                    box-shadow: 0 0 60px rgba(99, 102, 241, 0.12), 0 20px 40px rgba(0, 0, 0, 0.4);
                }

                .hero-balance::before {
                    content: '';
                    position: absolute;
                    width: 320px;
                    height: 320px;
                    background: radial-gradient(circle, rgba(99, 102, 241, 0.25) 0%, transparent 65%);
                    top: -80px;
                    right: -60px;
                    pointer-events: none;
                }

                .hero-balance::after {
                    content: '';
                    position: absolute;
                    width: 200px;
                    height: 200px;
                    background: radial-gradient(circle, rgba(168, 85, 247, 0.18) 0%, transparent 65%);
                    bottom: -60px;
                    left: -40px;
                    pointer-events: none;
                }

                .hero-badge {
                    display: inline-flex;
                    align-items: center;
                    gap: 0.4rem;
                    background: rgba(99, 102, 241, 0.18);
                    border: 1px solid rgba(99, 102, 241, 0.3);
                    color: var(--blue-soft);
                    font-size: 0.7rem;
                    font-weight: 600;
                    letter-spacing: 0.07em;
                    text-transform: uppercase;
                    padding: 0.3rem 0.75rem;
                    border-radius: 100px;
                    margin-bottom: 1.25rem;
                }

                .hero-balance-amount {
                    font-size: 3rem;
                    font-weight: 900;
                    letter-spacing: -2px;
                    line-height: 1;
                    margin-bottom: 0.5rem;
                    background: linear-gradient(135deg, #e0e7ff, #c7d2fe, #a5b4fc);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    background-clip: text;
                }

                .hero-balance-sub {
                    font-size: 0.8rem;
                    color: rgba(165, 180, 252, 0.6);
                    margin-bottom: 2rem;
                }

                .hero-stats {
                    display: flex;
                    gap: 2rem;
                }

                .hero-stat .stat-label {
                    font-size: 0.7rem;
                    color: rgba(165, 180, 252, 0.5);
                    text-transform: uppercase;
                    letter-spacing: 0.06em;
                    margin-bottom: 0.2rem;
                }

                .hero-stat .stat-val {
                    font-size: 0.925rem;
                    font-weight: 700;
                    color: #c7d2fe;
                }

                .hero-stat .stat-val.green {
                    color: #34d399;
                }

                .hero-stat .stat-val.red {
                    color: #f87171;
                }

                /* Account Card */
                .account-card {
                    border-radius: 20px;
                    background: var(--card);
                    border: 1px solid var(--border);
                    padding: 1.75rem 1.5rem;
                    display: flex;
                    flex-direction: column;
                    gap: 1.25rem;
                }

                .account-card-label {
                    font-size: 0.7rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.08em;
                    color: var(--muted);
                }

                .account-number-display {
                    font-size: 0.95rem;
                    font-weight: 700;
                    letter-spacing: 0.1em;
                    color: var(--text);
                    font-variant-numeric: tabular-nums;
                }

                .account-divider {
                    border: none;
                    border-top: 1px solid var(--border);
                }

                .quick-links {
                    display: flex;
                    flex-direction: column;
                    gap: 0.5rem;
                }

                .quick-link {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    padding: 0.5rem 0.75rem;
                    border-radius: var(--radius-sm);
                    font-size: 0.8rem;
                    font-weight: 500;
                    color: var(--muted2);
                    cursor: pointer;
                    transition: var(--transition);
                    background: none;
                    border: none;
                    text-decoration: none;
                    width: 100%;
                    text-align: left;
                }

                .quick-link:hover {
                    background: rgba(255, 255, 255, 0.04);
                    color: var(--text);
                }

                .quick-link .ql-left {
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                }

                .quick-link .ql-icon {
                    font-size: 0.9rem;
                }

                /* ── Action Cards Row ───────────────────────────────────── */
                .actions-row {
                    display: grid;
                    grid-template-columns: repeat(3, 1fr);
                    gap: 1.25rem;
                }

                .action-panel {
                    border-radius: var(--radius);
                    background: var(--card);
                    border: 1px solid var(--border);
                    padding: 1.5rem;
                    transition: var(--transition);
                }

                .action-panel:hover {
                    border-color: var(--border2);
                }

                .action-panel-header {
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                    margin-bottom: 1.25rem;
                }

                .ap-icon {
                    width: 40px;
                    height: 40px;
                    border-radius: 11px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.1rem;
                    flex-shrink: 0;
                }

                .ap-icon-deposit {
                    background: rgba(16, 185, 129, 0.15);
                }

                .ap-icon-send {
                    background: rgba(99, 102, 241, 0.15);
                }

                .ap-icon-withdraw {
                    background: rgba(245, 158, 11, 0.15);
                }

                .ap-title {
                    font-size: 0.9rem;
                    font-weight: 700;
                }

                .ap-desc {
                    font-size: 0.72rem;
                    color: var(--muted);
                }

                .field-group {
                    margin-bottom: 0.75rem;
                }

                .field-label {
                    font-size: 0.7rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.06em;
                    color: var(--muted);
                    margin-bottom: 0.3rem;
                }

                .field-input {
                    width: 100%;
                    padding: 0.6rem 0.875rem;
                    background: var(--bg2);
                    border: 1px solid var(--border);
                    border-radius: var(--radius-sm);
                    color: var(--text);
                    font-size: 0.875rem;
                    font-family: 'Inter', sans-serif;
                    transition: var(--transition);
                    outline: none;
                }

                .field-input:focus {
                    border-color: var(--blue);
                    box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.15);
                }

                .field-input::placeholder {
                    color: var(--muted);
                }

                .btn-full {
                    width: 100%;
                    padding: 0.65rem 1rem;
                    border-radius: var(--radius-sm);
                    font-size: 0.8rem;
                    font-weight: 700;
                    font-family: 'Inter', sans-serif;
                    cursor: pointer;
                    border: none;
                    transition: var(--transition);
                    letter-spacing: 0.02em;
                }

                .btn-green {
                    background: linear-gradient(135deg, #059669, #10b981);
                    color: #fff;
                    box-shadow: 0 4px 14px rgba(16, 185, 129, 0.3);
                }

                .btn-green:hover {
                    transform: translateY(-1px);
                    box-shadow: 0 6px 20px rgba(16, 185, 129, 0.4);
                }

                .btn-blue {
                    background: linear-gradient(135deg, #4f46e5, #6366f1);
                    color: #fff;
                    box-shadow: 0 4px 14px rgba(99, 102, 241, 0.3);
                }

                .btn-blue:hover {
                    transform: translateY(-1px);
                    box-shadow: 0 6px 20px rgba(99, 102, 241, 0.4);
                }

                .btn-amber {
                    background: linear-gradient(135deg, #d97706, #f59e0b);
                    color: #fff;
                    box-shadow: 0 4px 14px rgba(245, 158, 11, 0.3);
                }

                .btn-amber:hover {
                    transform: translateY(-1px);
                    box-shadow: 0 6px 20px rgba(245, 158, 11, 0.4);
                }

                /* ── Transactions ───────────────────────────────────────── */
                .section-header {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    margin-bottom: 1.25rem;
                }

                .section-header h3 {
                    font-size: 1rem;
                    font-weight: 700;
                }

                .section-header a {
                    font-size: 0.75rem;
                    color: var(--blue-soft);
                    text-decoration: none;
                    font-weight: 500;
                }

                .tx-card {
                    background: var(--card);
                    border: 1px solid var(--border);
                    border-radius: var(--radius);
                    overflow: hidden;
                }

                .tx-table {
                    width: 100%;
                    border-collapse: collapse;
                }

                .tx-table thead tr {
                    border-bottom: 1px solid var(--border);
                }

                .tx-table th {
                    padding: 0.75rem 1.25rem;
                    font-size: 0.68rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.08em;
                    color: var(--muted);
                    text-align: left;
                    background: rgba(255, 255, 255, 0.02);
                }

                .tx-table th:last-child {
                    text-align: right;
                }

                .tx-table tbody tr {
                    border-bottom: 1px solid var(--border);
                    transition: var(--transition);
                }

                .tx-table tbody tr:last-child {
                    border-bottom: none;
                }

                .tx-table tbody tr:hover {
                    background: rgba(255, 255, 255, 0.025);
                }

                .tx-table td {
                    padding: 1rem 1.25rem;
                }

                .tx-row-icon {
                    width: 36px;
                    height: 36px;
                    border-radius: 10px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 0.875rem;
                    flex-shrink: 0;
                }

                .tx-row-icon.deposit {
                    background: rgba(16, 185, 129, 0.15);
                }

                .tx-row-icon.withdrawal {
                    background: rgba(239, 68, 68, 0.15);
                }

                .tx-row-icon.transfer {
                    background: rgba(99, 102, 241, 0.15);
                }

                .tx-cell-main {
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                }

                .tx-meta-title {
                    font-size: 0.85rem;
                    font-weight: 600;
                }

                .tx-meta-sub {
                    font-size: 0.72rem;
                    color: var(--muted);
                }

                .tx-badge {
                    display: inline-block;
                    font-size: 0.65rem;
                    font-weight: 700;
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
                    padding: 0.2rem 0.55rem;
                    border-radius: 100px;
                }

                .tx-badge.deposit {
                    background: rgba(16, 185, 129, 0.15);
                    color: #34d399;
                }

                .tx-badge.withdrawal {
                    background: rgba(239, 68, 68, 0.12);
                    color: #f87171;
                }

                .tx-badge.transfer {
                    background: rgba(99, 102, 241, 0.15);
                    color: #818cf8;
                }

                .tx-amount {
                    font-size: 0.9rem;
                    font-weight: 700;
                    text-align: right;
                }

                .tx-amount.plus {
                    color: #34d399;
                }

                .tx-amount.minus {
                    color: #f87171;
                }

                .tx-amount.neutral {
                    color: #818cf8;
                }

                .tx-date {
                    font-size: 0.75rem;
                    color: var(--muted);
                }

                /* Empty state */
                .empty-state {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    padding: 4rem 2rem;
                    color: var(--muted);
                }

                .empty-icon {
                    font-size: 2.5rem;
                    margin-bottom: 1rem;
                    opacity: 0.5;
                }

                .empty-state h4 {
                    font-size: 0.95rem;
                    font-weight: 600;
                    color: var(--muted2);
                    margin-bottom: 0.25rem;
                }

                .empty-state p {
                    font-size: 0.8rem;
                }

                /* Flash */
                .flash-bar {
                    display: flex;
                    align-items: center;
                    gap: 0.625rem;
                    padding: 0.75rem 1.25rem;
                    border-radius: var(--radius-sm);
                    font-size: 0.8rem;
                    font-weight: 500;
                    margin-bottom: 0.5rem;
                }

                .flash-error {
                    background: rgba(239, 68, 68, 0.12);
                    color: #f87171;
                    border: 1px solid rgba(239, 68, 68, 0.2);
                }

                .flash-success {
                    background: rgba(16, 185, 129, 0.12);
                    color: #34d399;
                    border: 1px solid rgba(16, 185, 129, 0.2);
                }

                /* Animations */
                @keyframes fadeUp {
                    from {
                        opacity: 0;
                        transform: translateY(16px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .fade-up {
                    animation: fadeUp 0.45s ease both;
                }

                .delay-1 {
                    animation-delay: 0.08s;
                }

                .delay-2 {
                    animation-delay: 0.16s;
                }

                .delay-3 {
                    animation-delay: 0.24s;
                }

                /* Responsive */
                @media (max-width: 1000px) {
                    .hero-row {
                        grid-template-columns: 1fr 1fr;
                    }

                    .hero-balance {
                        grid-column: span 2;
                    }

                    .account-card {
                        grid-column: span 2;
                        flex-direction: row;
                        flex-wrap: wrap;
                    }
                }

                @media (max-width: 780px) {
                    .sidebar {
                        display: none;
                    }

                    .main {
                        margin-left: 0;
                    }

                    .hero-row,
                    .actions-row {
                        grid-template-columns: 1fr;
                    }

                    .hero-balance {
                        grid-column: span 1;
                    }

                    .page-body {
                        padding: 1rem;
                    }

                    .hero-balance-amount {
                        font-size: 2.25rem;
                    }
                }
            </style>
        </head>

        <body>

            <div class="shell">

                <!-- ── Sidebar ─────────────────────────────────────────────── -->
                <aside class="sidebar">
                    <a href="${pageContext.request.contextPath}/home" class="sidebar-logo">
                        <div class="logo-icon">🏦</div>
                        <div class="logo-name">Ace<span>Bank</span></div>
                    </a>

                    <nav class="sidebar-nav">
                        <span class="nav-label">Overview</span>
                        <a href="${pageContext.request.contextPath}/home" class="nav-item active">
                            <div class="nav-icon">📊</div> Dashboard
                        </a>

                        <span class="nav-label">Actions</span>
                        <a href="#deposit-section" class="nav-item">
                            <div class="nav-icon">⬇️</div> Deposit
                        </a>
                        <a href="#send-section" class="nav-item">
                            <div class="nav-icon">↗️</div> Send Money
                        </a>
                        <a href="#withdraw-section" class="nav-item">
                            <div class="nav-icon">⬆️</div> Withdraw
                        </a>

                        <span class="nav-label">Account</span>
                        <a href="${pageContext.request.contextPath}/ChangePassword.jsp" class="nav-item">
                            <div class="nav-icon">🔒</div> Change Password
                        </a>
                    </nav>

                    <div class="sidebar-footer">
                        <div class="user-chip">
                            <div class="user-avatar">
                                ${sessionScope.firstName != null ? sessionScope.firstName.substring(0,1).toUpperCase() :
                                'U'}
                            </div>
                            <div>
                                <div class="user-name">${sessionScope.firstName} ${sessionScope.lastName}</div>
                                <div class="user-role">Personal Account</div>
                            </div>
                        </div>
                    </div>
                </aside>

                <!-- ── Main ───────────────────────────────────────────────── -->
                <div class="main">

                    <!-- Topbar -->
                    <div class="topbar">
                        <div class="topbar-title">
                            <h2>Dashboard</h2>
                            <p>Welcome back, ${sessionScope.firstName} 👋</p>
                        </div>
                        <div class="topbar-actions">
                            <a href="${pageContext.request.contextPath}/ChangePassword.jsp" class="icon-btn"
                                title="Change Password">🔒</a>
                            <a href="${pageContext.request.contextPath}/Logout" class="icon-btn" title="Logout">🚪</a>
                        </div>
                    </div>

                    <!-- Page Body -->
                    <div class="page-body">

                        <!-- Flash Messages -->
                        <c:if test="${not empty param.error}">
                            <div class="flash-bar flash-error">⚠️ ${param.error}</div>
                        </c:if>
                        <c:if test="${not empty param.success}">
                            <div class="flash-bar flash-success">✅ ${param.success}</div>
                        </c:if>

                        <!-- ── Hero Row ─────────────────────────────────────── -->
                        <div class="hero-row fade-up">

                            <!-- Balance Hero -->
                            <div class="hero-balance">
                                <div class="hero-badge">💳 Available Balance</div>
                                <div class="hero-balance-amount">₹ ${sessionScope.balance}</div>
                                <div class="hero-balance-sub">Account is active and verified</div>
                                <div class="hero-stats">
                                    <div class="hero-stat">
                                        <div class="stat-label">Account No</div>
                                        <div class="stat-val">${sessionScope.accountNumber}</div>
                                    </div>
                                    <div class="hero-stat">
                                        <div class="stat-label">Type</div>
                                        <div class="stat-val">Savings</div>
                                    </div>
                                    <div class="hero-stat">
                                        <div class="stat-label">Status</div>
                                        <div class="stat-val green">● Active</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Account Card -->
                            <div class="account-card delay-1 fade-up">
                                <div>
                                    <div class="account-card-label">Account Holder</div>
                                    <div class="account-number-display" style="font-size:1.05rem; margin-top:0.25rem;">
                                        ${sessionScope.firstName} ${sessionScope.lastName}
                                    </div>
                                </div>
                                <hr class="account-divider">
                                <div>
                                    <div class="account-card-label">Account Number</div>
                                    <div class="account-number-display" style="margin-top:0.25rem;">
                                        ${sessionScope.accountNumber}
                                    </div>
                                </div>
                                <hr class="account-divider">
                                <div class="quick-links">
                                    <a href="${pageContext.request.contextPath}/ChangePassword.jsp" class="quick-link">
                                        <span class="ql-left"><span class="ql-icon">🔒</span> Change Password</span>
                                        <span>›</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/Logout" class="quick-link">
                                        <span class="ql-left"><span class="ql-icon">🚪</span> Sign Out</span>
                                        <span>›</span>
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- ── Actions Row ─────────────────────────────────── -->
                        <div class="actions-row">

                            <!-- Deposit -->
                            <div class="action-panel fade-up delay-1" id="deposit-section">
                                <div class="action-panel-header">
                                    <div class="ap-icon ap-icon-deposit">💚</div>
                                    <div>
                                        <div class="ap-title">Quick Deposit</div>
                                        <div class="ap-desc">Add funds to your account</div>
                                    </div>
                                </div>
                                <form action="${pageContext.request.contextPath}/home" method="post">
                                    <div class="field-group">
                                        <div class="field-label">Amount (₹)</div>
                                        <input class="field-input" type="text" name="deposit" placeholder="e.g. 5000"
                                            pattern="[0-9]*\.?[0-9]+" inputmode="decimal" required>
                                    </div>
                                    <button type="submit" class="btn-full btn-green">+ Deposit Now</button>
                                </form>
                            </div>

                            <!-- Send Money -->
                            <div class="action-panel fade-up delay-2" id="send-section">
                                <div class="action-panel-header">
                                    <div class="ap-icon ap-icon-send">💸</div>
                                    <div>
                                        <div class="ap-title">Send Money</div>
                                        <div class="ap-desc">Transfer to any account</div>
                                    </div>
                                </div>
                                <form action="${pageContext.request.contextPath}/home" method="post" id="sendForm">
                                    <div class="field-group">
                                        <div class="field-label">Recipient Account</div>
                                        <input class="field-input" type="text" name="toAccount"
                                            placeholder="Account number" inputmode="numeric" required>
                                    </div>
                                    <div class="field-group">
                                        <div class="field-label">Amount (₹)</div>
                                        <input class="field-input" type="text" name="toAmount" placeholder="e.g. 1000"
                                            pattern="[0-9]*\.?[0-9]+" inputmode="decimal" required>
                                    </div>
                                    <button type="button" class="btn-full btn-blue" onclick="openPinModal('sendForm')">↗
                                        Transfer Now</button>
                                </form>
                            </div>

                            <!-- Withdraw -->
                            <div class="action-panel fade-up delay-3" id="withdraw-section">
                                <div class="action-panel-header">
                                    <div class="ap-icon ap-icon-withdraw">🏧</div>
                                    <div>
                                        <div class="ap-title">Withdraw</div>
                                        <div class="ap-desc">Cash out from your balance</div>
                                    </div>
                                </div>
                                <form action="${pageContext.request.contextPath}/home" method="post" id="withdrawForm">
                                    <div class="field-group">
                                        <div class="field-label">Amount (₹)</div>
                                        <input class="field-input" type="text" name="withdraw" placeholder="e.g. 2000"
                                            pattern="[0-9]*\.?[0-9]+" inputmode="decimal" required>
                                    </div>
                                    <button type="button" class="btn-full btn-amber"
                                        onclick="openPinModal('withdrawForm')">⬆ Withdraw Now</button>
                                </form>
                            </div>

                        </div>

                        <!-- ── Transactions ────────────────────────────────── -->
                        <div class="fade-up delay-2">
                            <div class="section-header" style="flex-wrap: wrap; gap: 1rem;">
                                <h3>📋 Recent Transactions</h3>
                                <form action="${pageContext.request.contextPath}/downloadStatement" method="GET"
                                    style="display: flex; gap: 0.5rem; align-items: center; flex-wrap: wrap;">
                                    <input type="date" name="fromDate" class="field-input"
                                        style="width: auto; padding: 0.4rem 0.5rem; font-size: 0.75rem;" required>
                                    <span style="color: var(--muted);">to</span>
                                    <input type="date" name="toDate" class="field-input"
                                        style="width: auto; padding: 0.4rem 0.5rem; font-size: 0.75rem;" required>
                                    <button type="submit" name="format" value="pdf" class="btn-full btn-blue"
                                        style="width: auto; padding: 0.4rem 0.8rem; font-size: 0.75rem;">Download
                                        PDF</button>
                                    <button type="submit" name="format" value="csv" class="btn-full btn-green"
                                        style="width: auto; padding: 0.4rem 0.8rem; font-size: 0.75rem;">Download
                                        CSV</button>
                                </form>
                            </div>
                            <div class="tx-card">
                                <c:choose>
                                    <c:when test="${empty sessionScope.transactionDetailsList}">
                                        <div class="empty-state">
                                            <div class="empty-icon">📭</div>
                                            <h4>No transactions yet</h4>
                                            <p>Your deposits, transfers and withdrawals will appear here.</p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <table class="tx-table">
                                            <thead>
                                                <tr>
                                                    <th>Transaction</th>
                                                    <th>Type</th>
                                                    <th>Reference</th>
                                                    <th>Date</th>
                                                    <th>Amount</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="tx" items="${sessionScope.transactionDetailsList}">
                                                    <tr>
                                                        <td>
                                                            <div class="tx-cell-main">
                                                                <div class="tx-row-icon ${tx.txType().toLowerCase()}">
                                                                    <c:choose>
                                                                        <c:when test="${tx.txType() == 'DEPOSIT'}">⬇️
                                                                        </c:when>
                                                                        <c:when test="${tx.txType() == 'WITHDRAWAL'}">⬆️
                                                                        </c:when>
                                                                        <c:otherwise>↔️</c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                                <div>
                                                                    <div class="tx-meta-title">
                                                                        <c:choose>
                                                                            <c:when test="${tx.txType() == 'DEPOSIT'}">
                                                                                Deposit</c:when>
                                                                            <c:when
                                                                                test="${tx.txType() == 'WITHDRAWAL'}">
                                                                                Withdrawal</c:when>
                                                                            <c:otherwise>Transfer</c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                    <div class="tx-meta-sub">${tx.remark()}</div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <span
                                                                class="tx-badge ${tx.txType().toLowerCase()}">${tx.txType()}</span>
                                                        </td>
                                                        <td>
                                                            <span class="tx-meta-sub">
                                                                <c:choose>
                                                                    <c:when test="${tx.txType() == 'TRANSFER'}">
                                                                        ${tx.senderAccount() ==
                                                                        sessionScope.accountNumber ? '→ ' : '← '}
                                                                        ${tx.senderAccount() ==
                                                                        sessionScope.accountNumber ?
                                                                        tx.receiverAccount() : tx.senderAccount()}
                                                                    </c:when>
                                                                    <c:otherwise>—</c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                        </td>
                                                        <td class="tx-date">${tx.createdAt()}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${tx.txType() == 'DEPOSIT'}">
                                                                    <div class="tx-amount plus">+₹${tx.amount()}</div>
                                                                </c:when>
                                                                <c:when test="${tx.txType() == 'WITHDRAWAL'}">
                                                                    <div class="tx-amount minus">−₹${tx.amount()}</div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="tx-amount neutral">₹${tx.amount()}</div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                    </div><!-- /page-body -->
                </div><!-- /main -->

            </div><!-- /shell -->

            <!-- PIN Modal -->
            <div id="pinModal"
                style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.6); z-index:9999; align-items:center; justify-content:center;">
                <div
                    style="background:var(--card); padding:2rem; border-radius:var(--radius); width:320px; box-shadow:0 10px 25px rgba(0,0,0,0.5); border:1px solid var(--border);">
                    <h3 style="margin-bottom:0.5rem; font-size:1.1rem; color:var(--text);">Security Check</h3>
                    <p style="margin-bottom:1.5rem; font-size:0.85rem; color:var(--muted);">Please enter your 4-digit
                        Transaction PIN to proceed.</p>
                    <input type="password" id="modalPinInput" class="field-input" placeholder="4-Digit PIN"
                        maxlength="4" pattern="\d{4}"
                        style="text-align:center; font-size:1.2rem; letter-spacing:0.5em; padding-left:1rem;">
                    <br>
                    <div style="display:flex; gap:1rem; margin-top:1.5rem;">
                        <button type="button"
                            style="padding:0.65rem 1rem; border-radius:var(--radius-sm); border:1px solid var(--border); background:transparent; color:var(--text); flex:1; cursor:pointer;"
                            onclick="closePinModal()">Cancel</button>
                        <button type="button" class="btn-blue"
                            style="padding:0.65rem 1rem; border-radius:var(--radius-sm); flex:1; cursor:pointer; font-weight:bold; border:none;"
                            onclick="submitWithPin()">Confirm</button>
                    </div>
                </div>
            </div>

            <script>
                let currentFormId = null;

                function openPinModal(formId) {
                    const form = document.getElementById(formId);
                    if (!form.checkValidity()) {
                        form.reportValidity();
                        return;
                    }
                    currentFormId = formId;
                    document.getElementById('pinModal').style.display = 'flex';
                    document.getElementById('modalPinInput').value = '';
                    document.getElementById('modalPinInput').focus();
                }

                function closePinModal() {
                    document.getElementById('pinModal').style.display = 'none';
                    currentFormId = null;
                }

                function submitWithPin() {
                    const pin = document.getElementById('modalPinInput').value;
                    if (!/^\d{4}$/.test(pin)) {
                        alert('Please enter a valid 4-digit PIN.');
                        return;
                    }

                    const form = document.getElementById(currentFormId);
                    let hiddenInput = form.querySelector('input[name="transactionPin"]');
                    if (!hiddenInput) {
                        hiddenInput = document.createElement('input');
                        hiddenInput.type = 'hidden';
                        hiddenInput.name = 'transactionPin';
                        form.appendChild(hiddenInput);
                    }
                    hiddenInput.value = pin;

                    closePinModal();
                    form.submit();
                }
            </script>

        </body>

        </html>