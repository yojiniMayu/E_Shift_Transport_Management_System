--Insert Admin
INSERT INTO [E-Shift].[dbo].[admin_registration] (
    [Username],
    [Email],
    [ContactNo],
    [Password],
    [ConfirmPassword],
    [created_at],
    [updated_at]
) VALUES (
    'admin',
    'admin@eshift.com',
    '0212221234',
    '12345',
    '12345',
    '2025-07-23 23:01:08.5833333',
    '2025-07-23 23:01:08.5833333'
);


--Insert Customer
INSERT INTO [E-Shift].[dbo].[customer_registration] (
    [Username],
    [Email],
    [ContactNo],
    [Password],
    [ConfirmPassword],
    [created_at],
    [updated_at]
) VALUES (
    'user',
    'user@gmail.com',
    '0212221212',
    '12345',
    '12345',
    '2025-07-23 22:56:35.7441538',
    '2025-07-23 22:56:35.7441538'
);
