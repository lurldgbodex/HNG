export type ModalProps = {
  open: boolean;
  onClose: () => void;
  children: React.ReactNode;
  title?: string;
};

const Modal: React.FC<ModalProps> = ({ open, onClose, children, title }) => {
  if (!open) return null;

  return (
    <div className="fixed inset-0 z-40 flex items-center justify-center">
      <div className="absolute inset-0 bg-black opacity-40" onClick={onClose} />
      <div className="bg-white rounded-lg shadow-xl p-4 z-50 w-full max-w-md">
        {title && <h3 className="font-semibold mb-2">{title}</h3>}
        {children}
      </div>
    </div>
  );
};

export default Modal;
