import { Link, useNavigate } from "react-router-dom";
import { clearSession, getSession } from "../services/session";

const Header = () => {
  const nav = useNavigate();
  const session = getSession();

  const handleLogout = () => {
    clearSession();
    nav("/");
  };

  return (
    <header className="w-full border-b bg-white">
      <div className="max-w[1440px] mx-auto px-4 py-3 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded bg-gradient-to-br from-blue-600 to-indigo-600 flex items-center justify-center text-white font-bold">
            T
          </div>
          <Link to="/" className="text-lg font-semibold">
            TicketApp
          </Link>
        </div>
        <nav className="flex items-center gap-4">
          <Link to="/tickets" className="hidden md:inline-block">
            Tickets
          </Link>
          <Link to="/dashboard" className="hidden md:inline-block">
            Dashboard
          </Link>
          {session ? (
            <button onClick={handleLogout} className="btn-ghost">
              Logout
            </button>
          ) : (
            <div className="flex gap-2">
              <Link to="/auth/login" className="btn">
                Login
              </Link>
              <Link to="/auth/signup" className="btn-outline">
                Get Started
              </Link>
            </div>
          )}
        </nav>
      </div>
    </header>
  );
};

export default Header;
