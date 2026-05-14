<%--
  Simple Logout Button Component
  Usage: <%@ include file="../components/logoutModal.jsp" %>
  Trigger: Any element with onclick="openLogoutModal()"
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- ===== LOGOUT MODAL ===== -->
<div class="logout-overlay" id="logoutOverlay">
    <div class="logout-box" id="logoutBox">
        <div class="logout-icon">
            <i class="fa-solid fa-right-from-bracket"></i>
        </div>
        <h3>Sign out?</h3>
        <p>You'll be logged out of your RojgarSetu account.</p>
        <div class="logout-actions">
            <button class="btn-cancel" onclick="closeLogoutModal()">Cancel</button>
            <button class="btn-signout" onclick="doLogout()">Sign Out</button>
        </div>
    </div>
</div>

<style>
    .logout-overlay {
        display: none;
        position: fixed;
        inset: 0;
        background: rgba(0,0,0,.45);
        z-index: 9999;
        align-items: center;
        justify-content: center;
    }
    .logout-overlay.active { display: flex; }

    .logout-box {
        background: #fff;
        border-radius: 12px;
        padding: 32px 28px 24px;
        width: 100%;
        max-width: 340px;
        text-align: center;
        box-shadow: 0 8px 30px rgba(0,0,0,.15);
        animation: popIn .2s ease;
    }
    @keyframes popIn {
        from { transform: scale(.92); opacity: 0; }
        to   { transform: scale(1);   opacity: 1; }
    }

    .logout-icon {
        width: 52px;
        height: 52px;
        border-radius: 50%;
        background: #fff3f3;
        color: #e53e3e;
        font-size: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 16px;
    }

    .logout-box h3 {
        margin: 0 0 6px;
        font-size: 18px;
        font-weight: 600;
        color: #1a202c;
    }
    .logout-box p {
        margin: 0 0 24px;
        font-size: 14px;
        color: #718096;
        line-height: 1.5;
    }

    .logout-actions {
        display: flex;
        gap: 10px;
    }
    .logout-actions button {
        flex: 1;
        padding: 10px;
        border: none;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        transition: opacity .15s;
    }
    .logout-actions button:hover { opacity: .85; }

    .btn-cancel  { background: #edf2f7; color: #4a5568; }
    .btn-signout { background: #e53e3e; color: #fff; }
</style>

<script>
    function openLogoutModal() {
        document.getElementById('logoutOverlay').classList.add('active');
    }
    function closeLogoutModal() {
        document.getElementById('logoutOverlay').classList.remove('active');
    }
    function doLogout() {
        window.location.href = '<%= request.getContextPath() %>/logout';
    }

    // Close on backdrop click
    document.getElementById('logoutOverlay').addEventListener('click', function(e) {
        if (e.target === this) closeLogoutModal();
    });

    // Close on Escape
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') closeLogoutModal();
    });
</script>
