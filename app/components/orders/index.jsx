import { useEffect, useState } from "react";
import Table from "./table";
import LoadingSpinner from "../utils/LoadingSpinner";

const fetchOrders = async (sortBy, sortDirection) => {
  const params = new URLSearchParams({
    sort_column: sortBy,
    sort_direction: sortDirection
  });

  const response = await fetch(`/api/orders.json?${params}`)
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
  const [sortBy, setSortBy] = useState("created_at");
  const [sortDirection, setSortDirection] = useState("desc");

  const fulfillOrderHandler = async (orderId) => {
    const fulfilledOrder = await fulfillOrder(orderId);
    let updatedOrders = orders.map(order => {
      if (order.id == orderId) return { ...order, fulfilled: fulfilledOrder.fulfilled };

      return order;
    });

    setOrders(updatedOrders);
  }

  const sortHandler = (sortByColumnName) => {
    if (sortByColumnName == sortBy) {
      setSortDirection((prevSortBy) => prevSortBy == 'asc' ? 'desc' : 'asc')
    } else {
      setSortBy(sortByColumnName);
      setSortDirection('asc');
    }
  }

  useEffect(() => {
    const go = async () => {
      try {
        const orders = await fetchOrders(sortBy, sortDirection);
        setOrders(orders);
        setLoading(false);
      } catch (er) {
        setLoading(false);
        alert(`uh oh! ${er}`);
      }
    };
    go();
  }, [sortBy, sortDirection]);

  return (
    <>
      { loading ? <LoadingSpinner /> : <Table orders={orders} onFulfillOrderHandler={fulfillOrderHandler} onSortHandler={sortHandler} /> }
    </>
  )
};
