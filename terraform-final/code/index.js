const { Sequelize, Model, DataTypes } = require('sequelize');

const DB_NAME = process.env.DB_NAME;
const DB_USER = process.env.DB_USER;
const DB_PASSWORD = process.env.DB_PASSWORD;
const DB_HOST = process.env.DB_HOST;

const sequelize = new Sequelize(DB_NAME, DB_USER, DB_PASSWORD, {
  dialect: 'postgres',
  host: `/cloudsql/${DB_HOST}`,
  timestamps: false,
  dialectOptions: {
    socketPath: `/cloudsql/${DB_HOST}`,
  },
});
sequelize.sync().catch((err) => console.error(err));

class User extends Model {}

User.init({
  username: DataTypes.STRING,
  count: DataTypes.INTEGER,
}, { sequelize, modelName: 'user' });

/**
 * HTTP Cloud Function.
 *
 * @param {Object} req Cloud Function request context.
 *                     More info: https://expressjs.com/en/api.html#req
 * @param {Object} res Cloud Function response context.
 *                     More info: https://expressjs.com/en/api.html#res
 */
exports.helloGET = async (req, res) => {
  try {
    let lastUser;
    lastUser = await User.findOne({ where: { username: 'last' } });
    if (lastUser === null) {
      lastUser = await User.build({ username: 'last', count: 0 });
    }

    lastUser.count =  lastUser.count + 1;
    await lastUser.save();

    res.status(200).send(`Hello visitor: ${lastUser.count}`);
  } catch (err) {
    console.log(err);
    res.status(500).send(err.message);
  }
};