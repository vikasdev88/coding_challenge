import { useEffect, useState } from "react";
import Table from "./table";
import LoadingSpinner from "../utils/LoadingSpinner";

const fetchOrders = async () => {
  const response = await fetch("/api/orders.json");
  const data = await response.json();
  return data;
};

const fulfillOrder = async (orderId) => {
  const response = await fetch(`/api/orders/${orderId}/fulfill`,  {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
  });
  const data = await response.json();
  return data;
}

export default () => {
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);

  const fulfillOrderHandler = async (orderId) => {
    const fulfilledOrder = await fulfillOrder(orderId);
    let updatedOrders = orders.map(order => {
      if (order.id == orderId) return { ...order, fulfilled: fulfilledOrder.fulfilled };

      return order;
    });

    setOrders(updatedOrders);
  }

  useEffect(() => {
    const go = async () => {
      try {
        const orders = await fetchOrders();
        setOrders(orders);
        setLoading(false);
      } catch (er) {
        setLoading(false);
        alert(`uh oh! ${er}`);
      }
    };
    go();
  }, []);

  return (
    <>
      { loading ? <LoadingSpinner /> : <Table orders={orders} onFulfillOrderHandler={fulfillOrderHandler} /> }
    </>
  )
};
