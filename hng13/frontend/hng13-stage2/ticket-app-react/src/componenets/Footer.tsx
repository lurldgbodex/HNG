const Footer = () => {
  return (
    <footer className="w-full bg-[#0b1724] text-white mt-12">
      <div className="max-w-[1440px] mx-auto px-4 py-8 grid grid-cols-1 md:grid-cols-3 gap-4">
        <div>
          <h3 className="font-bold">TicketApp</h3>
          <p className="text-sm opacity-80">Manage tickets effortlessly.</p>
        </div>
        <div>
          <h4 className="font-semibold">Links</h4>
          <ul className="text-sm opacity-80">
            <li>Dashboard</li>
            <li>Tickets</li>
            <li>Support</li>
          </ul>
        </div>
        <div>
          <h4 className="font-semibold">Contact</h4>
          <p className="text-sm opacity-80">support@ticketapp.example</p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
