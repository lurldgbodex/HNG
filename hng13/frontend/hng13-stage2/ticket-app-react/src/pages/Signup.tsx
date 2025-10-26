import { useNavigate } from "react-router-dom";
import { useToast } from "../componenets/ToastProvider";
import { useState, type FormEvent } from "react";
import { createSession } from "../services/session";
import Header from "../componenets/Header";

const Signup = () => {
  const nav = useNavigate();
  const toast = useToast();
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [errors, setErrors] = useState<any>({});

  function submit(e: FormEvent) {
    e.preventDefault();
    const errs: any = {};
    if (!username) errs.username = "Username required";
    if (!password || password.length < 4)
      errs.password = "Password must be at least 4 chars";
    setErrors(errs);
    if (Object.keys(errs).length) return;
    createSession(username);
    toast.push({ type: "success", message: "Account created" });
    nav("/dashboard");
  }

  return (
    <div className="min-h-screen flex flex-col">
      <Header />
      <div className="max-w-[1440px] mx-auto px-4 py-6">
        <h2 className="text-2xl font-semibold mb-4">Get Started</h2>
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
          <div className="mt-3">
            <button className="btn" type="submit">
              Create account
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default Signup;
