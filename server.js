const express = require('express');
const stripe = require('stripe')('sk_test_51PRTWcP3YL5q5jjkHClMWhX4gPZC308gqaC4cIv7mjmxO59kGGPMTiTWyUCbzikQKCSgjOCdX9XXBIOGI6Tsp7Il00YLvgfNVN');
const bodyParser = require('body-parser');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(bodyParser.json());

app.post('/create-payment-intent', async (req, res) => {
  const { amount, currency } = req.body;

  try {
    const paymentIntent = await stripe.paymentIntents.create({
      amount: parseInt(amount),
      currency: currency,
    });

    res.status(200).send({
      clientSecret: paymentIntent.client_secret,
    });
  } catch (error) {
    res.status(500).send({
      error: error.message,
    });
  }
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
