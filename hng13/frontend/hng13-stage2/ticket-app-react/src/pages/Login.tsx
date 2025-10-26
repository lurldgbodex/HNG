import { Link, useNavigate } from "react-router-dom";
import { useToast } from "../componenets/ToastProvider";
import { useState } from "react";
import { createSession } from "../services/session";
import Header from "../componenets/Header";

interface errorType {
  username?: string;
  password?: string;
}

const Login = () => {
  const nav = useNavigate();
  const toast = useToast();
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [errors, setErrors] = useState<errorType>({});

  function submit(e: React.FormEvent) {
    e.preventDefault();

    const errs: any = {};
    if (!username) errs.username = "Username required";
    if (!password) errs.password = "Password required";
    setErrors(errs);
    if (Object.keys(errs).length) return;

    if (username.trim() && password.length >= 4) {
      createSession(username.trim());
      toast.push({ type: "success", message: "Signed in successfully" });
      nav("/dashboard");
    } else {
      toast.push({ type: "error", message: "Invalid credentials " });
    }
  }

  return (
    <div className="min-h-screen flex flex-col">
      <Header />
      <div className="max-w-[1440px] mx-auto px-4 py-6">
        <h2 className="text-2xl font-semibold mb-4">Login</h2>
        <form onSubmit={submit} className="max-w-md">
          <label className="block mb-2">
            Username
            <input
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              className="input"
            />
            {errors.username && (
              <div className="text-sm text-red-600">{errors.username}</div>
            )}
          </label>
          <label className="block mb-2">
            Password
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="input"
            />
            {errors.password && (
              <div className="text-sm text-red-600">{errors.password}</div>
            )}
          </label>
          <div className="flex gap-3 mt-3">
            <button className="btn" type="submit">
              Login
            </button>
            <Link to="/auth/signup" className="btn-outline">
              Create account
            </Link>
          </div>
        </form>
      </div>
    </div>
  );
};

export default Login;
