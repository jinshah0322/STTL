/*Triggers on Social Media App*/
USE socialmediaapp

/*Before Trigger*/
CREATE TRIGGER Users_InsteadOfDelete
ON Users
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM Posts WHERE UserID IN (SELECT UserID FROM deleted))
    BEGIN
        THROW 50000, 'Cannot delete user with related posts.', 16;
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Comments WHERE UserID IN (SELECT UserID FROM deleted))
    BEGIN
        THROW 50000, 'Cannot delete user with posted comments.', 16;
        RETURN;
    END
    DELETE FROM Users WHERE UserID IN (SELECT UserID FROM deleted);
END;


/*After Trigger*/
CREATE TRIGGER Users_AfterDelete
ON Users
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @DeletedUserID INT;
    SELECT @DeletedUserID = UserID FROM deleted;
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'User with ID ' + CAST(@DeletedUserID AS NVARCHAR(10)) + ' is deleted.';
    END
END;

/*Triggers on Library Management*/
USE librarymanagement

/*Before Trigger*/
CREATE TRIGGER Review_InsteadOfInsert
ON reviews
INSTEAD OF INSERT
AS
BEGIN 
	SET NOCOUNT ON
	INSERT INTO reviews (memberId, bookId, rating, comment, reviewDate, reviewSentiment) 
	SELECT 
		memberId,
		bookId,
		CASE WHEN rating BETWEEN 1 AND 5 THEN rating else 3 END,
		comment,reviewDate,reviewSentiment
	FROM inserted
END;

/*After Trigger*/
CREATE TRIGGER Review_AfterInsert
ON reviews
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON
	UPDATE r SET reviewSentiment=CASE WHEN i.rating>=3 THEN 1 ELSE 0 END
	FROM reviews r 
	INNER JOIN inserted i ON r.reviewID=i.reviewId;
END;


/*Triggers on Inventory Module*/
USE INVENTORYMODULE

/*Before Trigger*/
CREATE TRIGGER Orders_InsteadOfUpdate
ON orders
INSTEAD OF UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE o
    SET 
        orderDate = i.orderDate,
        userId = i.userId,
        productId = i.productId,
        quantity = i.quantity,
        totalAmount = o.totalAmount, 
        note = i.note,
        isDelivered = i.isDelivered
    FROM orders o
    INNER JOIN inserted i ON o.orderId = i.orderId;
END;

/*After Trigger*/
CREATE TRIGGER Orders_AfterUpdate
ON orders
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    PRINT 'Orders have been updated.';
END;