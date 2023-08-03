import React from "react";

const OrderTable = ({ orders, onFulfillOrderHandler, onSortHandler }) => {
  const clickHandler = (event, sortByColumnName) => {
    event.preventDefault();
    onSortHandler(sortByColumnName);
  }

  return (
    <table className="table orders-table">
      <thead>
        <tr>
          <th><a className="sortable" onClick={(event) => clickHandler(event, 'id')}>Order #</a></th>
          <th>Ordered at</th>
          <th><a className="sortable" onClick={(event) => clickHandler(event, 'pick_up_at')}>Pick up at</a></th>
          <th><a className="sortable" onClick={(event) => clickHandler(event, 'customer_name')}>Customer Name</a></th>
          <th>Item</th>
          <th>Qty</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        {orders.map((order) => (
          <OrderRow order={order} onFulfillOrderHandler={onFulfillOrderHandler} />
        ))}
      </tbody>
    </table>
  )
};

const OrderRow = ({ order, onFulfillOrderHandler }) => {
  const [disableAction, setDisableAction] = React.useState(false);

  const clickHandler = (orderId) => {
    setDisableAction(true)
    onFulfillOrderHandler(orderId)
  }

  return (
    <tr className={`order-${order.id}`}>
      <td>{order.id}</td>
      <td>{formatDate(order.created_at)}</td>
      <td>{formatDate(order.pick_up_at)}</td>
      <td>{order.customer_name}</td>
      <td>{order.item}</td>
      <td>{order.quantity}</td>
      <td>{order.fulfilled ? `Fulfilled` : `In progress`}</td>
      <td>
        {!order.fulfilled && <button disabled={disableAction} onClick={() => {clickHandler(order.id)}}>Fulfill order</button>}
      </td>
    </tr>
  );
};

const formatDate = (dateString) => {
  let date = new Date(dateString);
  return date.toLocaleDateString();
};

export default OrderTable;
