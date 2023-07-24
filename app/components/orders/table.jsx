const OrderTable = ({ orders }) => (
  <table className="table orders-table">
    <thead>
      <tr>
        <th>Order #</th>
        <th>Ordered at</th>
        <th>Pick up at</th>
        <th>Customer Name</th>
        <th>Item</th>
        <th>Qty</th>
        <th>Status</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      {orders.map((order) => (
        <OrderRow order={order} />
      ))}
    </tbody>
  </table>
);

const OrderRow = ({ order }) => {
  return (
    <tr>
      <td>{order.id}</td>
      <td>{formatDate(order.created_at)}</td>
      <td>{formatDate(order.pick_up_at)}</td>
      <td>{order.customer_name}</td>
      <td>{order.item}</td>
      <td>{order.quantity}</td>
      <td>{order.fulfilled ? `Fulfilled` : `In progress`}</td>
      <td></td>
    </tr>
  );
};

const formatDate = (dateString) => {
  let date = new Date(dateString);
  return date.toLocaleDateString();
};

export default OrderTable;
