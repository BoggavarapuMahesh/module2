# Assessment Contract
The `Assessment` contract is a simple contract that allows users to deposit and withdraw funds. It has an owner who can set the maximum withdrawal amount allowed. Let's explore its functionality in detail:

## Contract Variables

- `owner`: An address variable that stores the contract owner's address.
- `balance`: A uint256 variable that represents the current balance of the contract.
- `maxWithdrawalAmount`: A uint256 variable that determines the maximum amount that can be withdrawn.

## Events

- `Deposit`: An event emitted when a user makes a deposit, indicating the account address and the deposited amount.
- `Withdraw`: An event emitted when a withdrawal is made, indicating the account address and the withdrawn amount.

## Constructor

- The constructor function initializes the contract with an initial balance and a maximum withdrawal amount.
- The `initBalance` parameter sets the initial balance of the contract.
- The `maxWithdrawal` parameter sets the maximum withdrawal amount allowed.
- The `payable` modifier allows the contract to accept ether during deployment.
- The `msg.sender` is set as the contract owner.
- The initial balance and maximum withdrawal amount are set.

## Functionality

1. `getBalance()`: This function allows users to check the current balance of the contract. It returns the `balance` variable.

2. `deposit()`: Users can deposit funds into the contract by calling this function. It requires a positive deposit amount.
   - The `msg.value` represents the value of the deposit made by the caller.
   - The function updates the `balance` by adding the deposited amount.
   - An `assert` statement verifies that the balance has been updated correctly.
   - The `Deposit` event is emitted, indicating the account address and the deposited amount.

3. `withdraw(uint256 withdrawAmount)`: Only the contract owner can withdraw funds from the contract. They specify the amount to withdraw.
   - The function checks if the caller is the contract owner, reverting the transaction if not.
   - It verifies if the contract has sufficient balance for the withdrawal. If not, it reverts with an `InsufficientBalance` error.
   - It checks if the withdrawal amount exceeds the maximum withdrawal limit. If it does, it reverts with an `ExceedsMaxWithdrawal` error.
   - The function deducts the `withdrawAmount` from the `balance`.
   - An `assert` statement verifies that the balance has been updated correctly.
   - The funds are transferred to the contract owner's address using the `owner.transfer()` function.
   - The `Withdraw` event is emitted, indicating the account address and the withdrawn amount.

4. `setMaxWithdrawal(uint256 newMaxWithdrawal)`: Only the contract owner can update the maximum withdrawal amount.
   - The function checks if the caller is the contract owner, reverting the transaction if not.
   - It updates the `maxWithdrawalAmount` with the new value provided.
