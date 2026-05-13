<%--
  Shared Logout Confirmation Modal — Premium animated experience.
  Include this at the bottom of any page (before </body>) that has a logout button.
  
  Usage:
    <%@ include file="../components/logoutModal.jsp" %>
  
  Trigger:
    Any element with onclick="openLogoutModal()" will open it.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- ===== LOGOUT CONFIRMATION MODAL ===== -->
<div class="logout-modal-overlay" id="logoutModalOverlay">
    <div class="logout-modal" id="logoutModal">

        <!-- Close button -->
        <button class="logout-modal-close" onclick="closeLogoutModal()" aria-label="Close">
            <i class="fa-solid fa-xmark"></i>
        </button>

        <!-- Step 1: Confirmation -->
        <div class="logout-step logout-step-confirm" id="logoutStepConfirm">
            <div class="logout-icon-ring">
                <div class="logout-icon-circle">
                    <i class="fa-solid fa-right-from-bracket"></i>
                </div>
            </div>
            <h3>Leaving so soon?</h3>
            <p>You are about to sign out of your <strong>RojgarSetu</strong> account. Any unsaved changes will be lost.</p>
            <div class="logout-modal-actions">
                <button class="logout-btn-cancel" onclick="closeLogoutModal()">
                    <i class="fa-solid fa-arrow-left"></i> Stay Here
                </button>
                <button class="logout-btn-confirm" onclick="confirmLogout()">
                    Sign Out <i class="fa-solid fa-arrow-right-from-bracket"></i>
                </button>
            </div>
        </div>

        <!-- Step 2: Logging out animation -->
        <div class="logout-step logout-step-progress" id="logoutStepProgress" style="display:none;">
            <div class="logout-spinner-ring">
                <div class="logout-spinner"></div>
            </div>
            <h3>Signing you out...</h3>
            <p>Thank you for visiting. See you again soon!</p>
            <div class="logout-progress-bar">
                <div class="logout-progress-fill" id="logoutProgressFill"></div>
            </div>
        </div>

        <!-- Step 3: Goodbye -->
        <div class="logout-step logout-step-bye" id="logoutStepBye" style="display:none;">
            <div class="logout-check-ring">
                <i class="fa-solid fa-check"></i>
            </div>
            <h3>Goodbye! 👋</h3>
            <p>You've been signed out successfully. Redirecting...</p>
        </div>

    </div>
</div>

<script>
    // ===== LOGOUT MODAL LOGIC =====
    function openLogoutModal() {
        const overlay = document.getElementById('logoutModalOverlay');
        const modal   = document.getElementById('logoutModal');

        // Reset to step 1
        document.getElementById('logoutStepConfirm').style.display  = '';
        document.getElementById('logoutStepProgress').style.display = 'none';
        document.getElementById('logoutStepBye').style.display      = 'none';

        overlay.classList.add('active');
        setTimeout(function() { modal.classList.add('active'); }, 30);
    }

    function closeLogoutModal() {
        const overlay = document.getElementById('logoutModalOverlay');
        const modal   = document.getElementById('logoutModal');
        modal.classList.remove('active');
        setTimeout(function() { overlay.classList.remove('active'); }, 300);
    }

    function confirmLogout() {
        // Switch to progress step
        document.getElementById('logoutStepConfirm').style.display  = 'none';
        document.getElementById('logoutStepProgress').style.display = '';

        // Animate progress bar
        var fill = document.getElementById('logoutProgressFill');
        fill.style.width = '0%';
        setTimeout(function() { fill.style.width = '100%'; }, 60);

        // After 1.6s show goodbye step
        setTimeout(function() {
            document.getElementById('logoutStepProgress').style.display = 'none';
            document.getElementById('logoutStepBye').style.display      = '';
        }, 1600);

        // After 2.4s redirect to logout
        setTimeout(function() {
            // Use the contextPath variable set by JSP
            window.location.href = '<%= request.getContextPath() %>/logout';
        }, 2400);
    }

    // Close on overlay click
    document.getElementById('logoutModalOverlay').addEventListener('click', function(e) {
        if (e.target === this) closeLogoutModal();
    });

    // Close on Escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') closeLogoutModal();
    });
</script>
