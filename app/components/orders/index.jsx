import { useEffect, useState } from "react";
import Table from "./table";

const fetchOrders = async () => {
  const response = await fetch("/api/orders.json");
  const data = await response.json();
  return data;
};

export default () => {
  const [orders, setOrders] = useState([]);

  useEffect(() => {
    const go = async () => {
      try {
        const orders = await fetchOrders();
        setOrders(orders);
      } catch (er) {
        alert(`uh oh! ${er}`);
      }
    };
    go();
  }, []);

  return <Table orders={orders} />;
};
