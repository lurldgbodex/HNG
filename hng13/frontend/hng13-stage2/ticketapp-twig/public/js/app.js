// public/js/app.js
(() => {
    // keys
    const SESSION_KEY = "ticketapp_session";
    const TICKETS_KEY = "ticketapp_tickets";

    /* ------------------ Helpers ------------------ */
    function lsGet(key) {
        try {
            return JSON.parse(localStorage.getItem(key));
        } catch {
            return null;
        }
    }
    function lsSet(key, val) {
        localStorage.setItem(key, JSON.stringify(val));
    }
    function lsRemove(key) {
        localStorage.removeItem(key);
    }

    function nowISO() {
        return new Date().toISOString();
    }
    function randId() {
        return Math.random().toString(36).slice(2);
    }

    /* ------------------ Toasts ------------------ */
    const toastRoot = (() => {
        const el = document.createElement("div");
        el.style.position = "fixed";
        el.style.right = "1rem";
        el.style.bottom = "1rem";
        el.style.zIndex = "9999";
        document.body.appendChild(el);
        return el;
    })();

    function toast(type, message) {
        const item = document.createElement("div");
        item.className = "card";
        item.style.minWidth = "220px";
        item.style.padding = "0.6rem 1rem";
        item.style.marginTop = ".5rem";
        item.style.color = "#fff";
        item.style.fontWeight = "600";
        if (type === "success") item.style.background = "#059669";
        else if (type === "error") item.style.background = "#dc2626";
        else item.style.background = "#2563eb";
        item.textContent = message;
        toastRoot.appendChild(item);
        setTimeout(() => {
            item.style.transition = "opacity .3s, transform .3s";
            item.style.opacity = "0";
            item.style.transform = "translateY(8px)";
            setTimeout(() => item.remove(), 350);
        }, 3000);
    }

    /* ------------------ Auth helpers ------------------ */
    function createSession(username) {
        const token = randId();
        const s = { token, username, createdAt: nowISO() };
        lsSet(SESSION_KEY, s);
        return s;
    }
    function getSession() {
        return lsGet(SESSION_KEY);
    }
    function clearSession() {
        lsRemove(SESSION_KEY);
    }

    /* protect routes: if on dashboard or tickets and not logged in, redirect */
    function routeGuard() {
        const protectedPaths = ["/dashboard", "/tickets"];
        const p = location.pathname.replace(/\/+$/, "");
        if (protectedPaths.includes(p) && !getSession()) {
            toast("error", "Your session has expired — please log in again.");
            location.replace("/auth/login");
        }
    }

    /* ------------------ Validation ------------------ */
    function isValidStatus(s) {
        return ["open", "in_progress", "closed"].includes(s);
    }
    function validateTicketInput(data) {
        const errors = {};
        if (!data.title || !String(data.title).trim())
            errors.title = "Title is required.";
        else if (String(data.title).length > 120)
            errors.title = "Title must be at most 120 characters.";
        if (!data.status) errors.status = "Status is required.";
        else if (!isValidStatus(data.status))
            errors.status = "Status must be one of: open, in_progress, closed.";
        if (data.description && String(data.description).length > 2000)
            errors.description = "Description is too long.";
        return errors;
    }

    /* ------------------ Tickets storage ------------------ */
    function getTickets() {
        return lsGet(TICKETS_KEY) || [];
    }
    function setTickets(tickets) {
        lsSet(TICKETS_KEY, tickets);
    }

    /* ------------------ DOM utilities ------------------ */
    function q(sel, scope = document) {
        return scope.querySelector(sel);
    }
    function qa(sel, scope = document) {
        return Array.from(scope.querySelectorAll(sel));
    }

    /* ------------------ Login / Signup pages wiring ------------------ */
    function initAuthPages() {
        const loginForm = q("#loginForm");
        if (loginForm) {
            loginForm.addEventListener("submit", (ev) => {
                ev.preventDefault();
                const username = q("#login_username").value.trim();
                const password = q("#login_password").value;
                const errors = {};
                if (!username) errors.username = "Username required";
                if (!password) errors.password = "Password required";
                qa(".error").forEach((e) => (e.textContent = ""));
                if (Object.keys(errors).length) {
                    for (const k in errors) {
                        const el = q(`.error[data-for="${k}"]`);
                        if (el) el.textContent = errors[k];
                    }
                    return;
                }
                // Accept any username/password with password length >= 4
                if (password.length >= 4) {
                    createSession(username);
                    toast("success", "Signed in successfully");
                    location.replace("/dashboard");
                } else {
                    toast("error", "Invalid credentials");
                }
            });
        }

        const signupForm = q("#signupForm");
        if (signupForm) {
            signupForm.addEventListener("submit", (ev) => {
                ev.preventDefault();
                const username = q("#signup_username").value.trim();
                const password = q("#signup_password").value;
                const errors = {};
                if (!username) errors.username = "Username required";
                if (!password || password.length < 4)
                    errors.password = "Password must be at least 4 chars";
                qa(".error").forEach((e) => (e.textContent = ""));
                if (Object.keys(errors).length) {
                    for (const k in errors) {
                        const el = q(`.error[data-for="${k}"]`);
                        if (el) el.textContent = errors[k];
                    }
                    return;
                }
                createSession(username);
                toast("success", "Account created");
                location.replace("/dashboard");
            });
        }
    }

    /* ------------------ Dashboard wiring ------------------ */
    function initDashboard() {
        if (!q("#statTotal")) return;
        // logout button
        const logoutBtn = q("#logoutBtn");
        if (logoutBtn) {
            logoutBtn.addEventListener("click", () => {
                clearSession();
                toast("info", "Logged out");
                location.replace("/");
            });
        }

        const session = getSession();
        if (!session) {
            routeGuard();
            return;
        }

        // compute stats and show
        const tickets = getTickets();
        q("#statTotal").textContent = tickets.length;
        q("#statOpen").textContent = tickets.filter(
            (t) => t.status === "open"
        ).length;
        q("#statClosed").textContent = tickets.filter(
            (t) => t.status === "closed"
        ).length;
    }

    /* ------------------ Tickets page wiring ------------------ */
    function mkStatusBadge(status) {
        const span = document.createElement("span");
        span.textContent = status.replace("_", " ");
        span.style.padding = "4px 8px";
        span.style.borderRadius = "999px";
        span.style.fontSize = "12px";
        if (status === "open") {
            span.style.background = "#dcfce7";
            span.style.color = "#166534";
        } else if (status === "in_progress") {
            span.style.background = "#fffbeb";
            span.style.color = "#92400e";
        } else {
            span.style.background = "#f3f4f6";
            span.style.color = "#374151";
        }
        return span;
    }

    function createTicketCard(ticket) {
        const card = document.createElement("article");
        card.className = "card";
        const title = document.createElement("h4");
        title.textContent = ticket.title;
        title.style.fontWeight = "700";
        const desc = document.createElement("p");
        desc.textContent = ticket.description || "";
        desc.style.color = "#475569";
        const meta = document.createElement("div");
        meta.style.display = "flex";
        meta.style.justifyContent = "space-between";
        meta.style.alignItems = "flex-start";

        const left = document.createElement("div");
        left.appendChild(title);
        left.appendChild(desc);
        const right = document.createElement("div");
        right.style.textAlign = "right";
        right.appendChild(mkStatusBadge(ticket.status));

        const actionsDiv = document.createElement("div");
        actionsDiv.style.marginTop = "8px";
        const editBtn = document.createElement("button");
        editBtn.className = "btn-ghost";
        editBtn.textContent = "Edit";
        const delBtn = document.createElement("button");
        delBtn.className = "btn-ghost";
        delBtn.style.color = "#dc2626";
        delBtn.textContent = "Delete";
        actionsDiv.appendChild(editBtn);
        actionsDiv.appendChild(delBtn);
        right.appendChild(actionsDiv);

        meta.appendChild(left);
        meta.appendChild(right);
        card.appendChild(meta);

        const created = document.createElement("div");
        created.style.fontSize = "12px";
        created.style.color = "#94a3b8";
        created.textContent =
            "Created: " + new Date(ticket.createdAt).toLocaleString();
        card.appendChild(created);

        // handlers
        editBtn.addEventListener("click", () => openEditModal(ticket));
        delBtn.addEventListener("click", () => {
            if (!confirm("Delete this ticket?")) return;
            const list = getTickets().filter((t) => t.id !== ticket.id);
            setTickets(list);
            toast("success", "Ticket deleted");
            renderTickets();
        });

        return card;
    }

    function renderTickets() {
        const ticketsList = q("#ticketsList");
        if (!ticketsList) return;
        const tickets = getTickets();
        ticketsList.innerHTML = "";
        if (tickets.length === 0) {
            const placeholder = document.createElement("div");
            placeholder.className = "card";
            placeholder.textContent = "No tickets yet.";
            ticketsList.appendChild(placeholder);
        } else {
            tickets.forEach((t) =>
                ticketsList.appendChild(createTicketCard(t))
            );
        }
        // stats
        q("#t_total").textContent = tickets.length;
        q("#t_open").textContent = tickets.filter(
            (t) => t.status === "open"
        ).length;
        q("#t_in_progress").textContent = tickets.filter(
            (t) => t.status === "in_progress"
        ).length;
        q("#t_closed").textContent = tickets.filter(
            (t) => t.status === "closed"
        ).length;
    }

    /* ------------------ Modal (create/edit) ------------------ */
    function openCreateModal() {
        openFormModal(
            { title: "", description: "", status: "open", priority: "medium" },
            (data) => {
                const errs = validateTicketInput(data);
                if (Object.keys(errs).length) {
                    showFieldErrors(errs);
                    return false;
                }
                const newTicket = {
                    id: randId(),
                    title: String(data.title),
                    description: String(data.description || ""),
                    priority: data.priority || "medium",
                    status: data.status,
                    createdAt: nowISO(),
                };
                const list = getTickets();
                list.unshift(newTicket);
                setTickets(list);
                toast("success", "Ticket created");
                renderTickets();
                return true;
            }
        );
    }

    function openEditModal(ticket) {
        openFormModal(ticket, (data) => {
            const errs = validateTicketInput(data);
            if (Object.keys(errs).length) {
                showFieldErrors(errs);
                return false;
            }
            const list = getTickets().map((t) =>
                t.id === ticket.id
                    ? Object.assign({}, t, data, { updatedAt: nowISO() })
                    : t
            );
            setTickets(list);
            toast("success", "Ticket updated");
            renderTickets();
            return true;
        });
    }

    function showFieldErrors(errors) {
        // populate .error inside modal if any
        qa("#modalRoot .error").forEach((el) => (el.textContent = ""));
        for (const k in errors) {
            const el = q(`#modalRoot .error[data-for="${k}"]`);
            if (el) el.textContent = errors[k];
        }
    }

    function openFormModal(initialData, onSubmit) {
        const root = q("#modalRoot");
        if (!root) return;
        root.innerHTML = "";
        const overlay = document.createElement("div");
        overlay.style.position = "fixed";
        overlay.style.inset = "0";
        overlay.style.background = "rgba(2,6,23,0.4)";
        overlay.style.zIndex = "9998";
        overlay.addEventListener("click", closeModal);
        const box = document.createElement("div");
        box.className = "card";
        box.style.position = "fixed";
        box.style.left = "50%";
        box.style.top = "50%";
        box.style.transform = "translate(-50%,-50%)";
        box.style.width = "min(96%,720px)";
        box.style.zIndex = "9999";
        const title = document.createElement("h3");
        title.textContent =
            initialData && initialData.id ? "Edit ticket" : "Create ticket";
        title.style.fontWeight = "700";
        box.appendChild(title);

        const form = document.createElement("form");
        form.style.display = "grid";
        form.style.gap = "8px";
        form.style.marginTop = "8px";

        // Title
        const labelT = document.createElement("label");
        labelT.textContent = "Title";
        const inputT = document.createElement("input");
        inputT.className = "input";
        inputT.value = initialData.title || "";
        labelT.appendChild(inputT);
        const errT = document.createElement("div");
        errT.className = "error";
        errT.setAttribute("data-for", "title");
        form.appendChild(labelT);
        form.appendChild(errT);

        // Status
        const labelS = document.createElement("label");
        labelS.textContent = "Status";
        const selectS = document.createElement("select");
        selectS.className = "input";
        ["open", "in_progress", "closed"].forEach((v) => {
            const o = document.createElement("option");
            o.value = v;
            o.textContent = v;
            if (v === initialData.status) o.selected = true;
            selectS.appendChild(o);
        });
        labelS.appendChild(selectS);
        const errS = document.createElement("div");
        errS.className = "error";
        errS.setAttribute("data-for", "status");
        form.appendChild(labelS);
        form.appendChild(errS);

        // Description
        const labelD = document.createElement("label");
        labelD.textContent = "Description";
        const ta = document.createElement("textarea");
        ta.className = "input";
        ta.value = initialData.description || "";
        labelD.appendChild(ta);
        const errD = document.createElement("div");
        errD.className = "error";
        errD.setAttribute("data-for", "description");
        form.appendChild(labelD);
        form.appendChild(errD);

        // Buttons
        const actions = document.createElement("div");
        actions.style.display = "flex";
        actions.style.gap = "8px";
        actions.style.justifyContent = "flex-end";
        const submitBtn = document.createElement("button");
        submitBtn.className = "btn";
        submitBtn.type = "submit";
        submitBtn.textContent = "Save";
        const cancelBtn = document.createElement("button");
        cancelBtn.className = "btn-outline";
        cancelBtn.type = "button";
        cancelBtn.textContent = "Cancel";
        actions.appendChild(submitBtn);
        actions.appendChild(cancelBtn);
        form.appendChild(actions);

        form.addEventListener("submit", (e) => {
            e.preventDefault();
            qa("#modalRoot .error").forEach((el) => (el.textContent = ""));
            const payload = {
                title: inputT.value.trim(),
                status: selectS.value,
                description: ta.value.trim(),
            };
            const ok = onSubmit(payload);
            if (ok) closeModal();
        });
        cancelBtn.addEventListener("click", closeModal);

        box.appendChild(form);
        root.appendChild(overlay);
        root.appendChild(box);

        function closeModal() {
            root.innerHTML = "";
        }
    }

    /* ------------------ Initialize tickets page behaviors ------------------ */
    function initTicketsPage() {
        const createBtn = q("#createTicketBtn");
        if (createBtn) createBtn.addEventListener("click", openCreateModal);
        // logout handlers on top
        const logoutBtns = [q("#logoutBtnTop"), q("#logoutBtn")].filter(
            Boolean
        );
        logoutBtns.forEach((btn) =>
            btn.addEventListener("click", () => {
                clearSession();
                toast("info", "Logged out");
                location.replace("/");
            })
        );

        routeGuard();
        renderTickets();
    }

    /* ------------------ On DOM ready ------------------ */
    document.addEventListener("DOMContentLoaded", () => {
        initAuthPages();
        initDashboard();
        initTicketsPage();
        // Global header login state: change login links if session exists
        const sess = getSession();
        if (sess) {
            // replace any login link text with username or logout
            qa('a[href="/auth/login"]').forEach(
                (a) => (a.textContent = "Dashboard")
            );
            qa('a[href="/auth/register"]').forEach(
                (a) => (a.textContent = "Create")
            );
        }

        // If on a protected page and no session -> redirect
        routeGuard();
    });
})();
