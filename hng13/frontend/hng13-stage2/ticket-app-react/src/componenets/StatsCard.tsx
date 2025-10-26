interface StatsCardProps {
  title: string;
  value: number;
  icon: string;
  gradient: string;
}

const StatsCard: React.FC<StatsCardProps> = ({
  title,
  value,
  icon,
  gradient,
}) => {
  return (
    <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow duration-200">
      <div className="flex items-center justify-between">
        <div>
          <p className="text-sm font-medium text-gray-600">{title}</p>
          <p className="text-3xl font-bold text-gray-900 mt-2">{value}</p>
        </div>
        <div
          className={`w-12 h-12 bg-gradient-to-r ${gradient} rounded-lg flex items-center justify-center`}
        >
          <span className="text-white text-xl">{icon}</span>
        </div>
      </div>
    </div>
  );
};

export default StatsCard;
