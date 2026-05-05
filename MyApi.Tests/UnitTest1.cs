namespace MyApi.Tests;

public class UnitTest1
{
    [Fact]
    public void Test_Math_Logic_Success()
    {
        // Bài test giả định: 1 + 1 phải bằng 2. 
        // Nếu anh muốn demo lỗi (màu đỏ), anh vào đây đổi số 2 thành số 3.
        int result = 1 + 1;
        Assert.Equal(2, result);
    }
}