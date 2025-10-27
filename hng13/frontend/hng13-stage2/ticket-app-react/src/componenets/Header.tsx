import { Link, NavLink, useNavigate } from "react-router-dom";
import { clearSession, getSession } from "../services/session";

const Header = () => {
  const nav = useNavigate();
  const session = getSession();

  const handleLogout = () => {
    clearSession();
    nav("/");
  };

  return (
    <header className="w-full border-b border-blue-600 bg-white">
      <div className="max-w-[1440px] mx-auto px-4 py-3 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded bg-gradient-to-br from-blue-600 to-indigo-600 flex items-center justify-center text-white font-bold">
            T
          </div>
          <Link to="/" className="text-lg font-semibold">
            TicketApp
          </Link>
        </div>
        <nav className="flex items-center gap-4">
          <NavLink
            to="/tickets"
            className={({ isActive }) =>
              `hidden md:inline-block font-bold ${
                isActive ? "text-blue-600" : "text-gray-600 hover:text-blue-500"
              }`
            }
          >
            Tickets
          </NavLink>
          <NavLink
            to="/dashboard"
            className={({ isActive }) =>
              `hidden md:inline-block font-bold ${
                isActive ? "text-blue-600" : "text-gray-600 hover:text-blue-500"
              }`
            }
          >
            Dashboard
          </NavLink>
          {session ? (
            <button onClick={handleLogout} className="btn-ghost">
              Logout
            </button>
          ) : (
            <div className="flex gap-2">
              <NavLink
                to="/auth/login"
                className={({ isActive }) =>
                  `btn ${isActive ? "bg-blue-600 text-white" : ""}`
                }
              >
                Login
              </NavLink>
              <NavLink
                to="/auth/signup"
                className={({ isActive }) =>
                  `btn-outline ${
                    isActive ? "border-blue-600 text-blue-600" : ""
                  }`
                }
              >
                Get Started
              </NavLink>
            </div>
          )}
        </nav>
      </div>
    </header>
  );
};

export default Header;
