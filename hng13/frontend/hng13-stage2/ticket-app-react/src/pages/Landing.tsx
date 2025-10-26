import { Link } from "react-router-dom";
import Footer from "../componenets/Footer";
import Header from "../componenets/Header";

const Landing = () => {
  return (
    <div className="relative overflow-hidden min-h-screen flex flex-col items-center justify-center text-center bg-gradient-to-b from-blue-50 to-white">
      <Header />
      <main className="flex-1 flex flex-col items-center justify-center w-full">
        <section className="z-10 px-4 max-w-3xl mt-10">
          <h1 className="text-4xl sm:text-5xl font-extrabold text-gray-900 mb-4">
            Manage Your <span className="text-blue-600">Event Tickets</span>{" "}
            with Ease
          </h1>
          <p className="text-gray-600 text-lg sm:text-xl mb-6">
            From planning to execution — simplify your ticket handling,
            streamline your events, and elevate attendee experiences.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link to="/auth/login" className="btn">
              Get Started
            </Link>
            <Link to="/auth/signup" className="btn-outline">
              Login
            </Link>
          </div>
        </section>

        <section className="relative z-10 mt-20 grid grid-cols-1 md:grid-cols-3 gap-6 px-6 max-w-6xl w-full align-middle mx-auto">
          <div className="bg-white shadow-md rounded-2xl p-6 hover:shadow-xl transition">
            <h3 className="text-xl font-semibold text-gray-900 mb-2">
              Create Tickets Instantly
            </h3>
            <p className="text-gray-600">
              Quickly generate new tickets for your events and manage them all
              in one place.
            </p>
          </div>
          <div className="bg-white shadow-md rounded-2xl p-6 hover:shadow-xl transition">
            <h3 className="text-xl font-semibold text-gray-900 mb-2">
              Track Ticket Status
            </h3>
            <p className="text-gray-600">
              Stay updated with ticket progress — open, in progress, or closed —
              in real time.
            </p>
          </div>
          <div className="bg-white shadow-md rounded-2xl p-6 hover:shadow-xl transition">
            <h3 className="text-xl font-semibold text-gray-900 mb-2">
              Analyze & Optimize
            </h3>
            <p className="text-gray-600">
              Gain insights into ticket performance and make informed decisions
              effortlessly.
            </p>
          </div>
        </section>
      </main>
      <Footer />
    </div>
  );
};

export default Landing;
