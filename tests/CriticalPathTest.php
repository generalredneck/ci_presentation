<?php
class CriticalPathTest extends PHPUnit_Extensions_SeleniumTestCase
{
  protected function setUp()
  {
    $this->setBrowser("*chrome");
    $this->setBrowserUrl(getenv('SELENIUM_BROWSER_URL'));
  }

  public function testLogout()
  {
    $this->open("/");
    $this->type("id=edit-name", "admin");
    $this->type("id=edit-pass", "adm1n");
    $this->click("id=edit-submit");
    $this->waitForPageToLoad("30000");
    $this->click("link=Log out");
    $this->waitForPageToLoad("30000");
  }
  public function testLogin()
  {
    $this->open("/");
    $this->type("id=edit-name", "admin");
    $this->type("id=edit-pass", "adm1n");
    $this->click("id=edit-submit");
    $this->waitForPageToLoad("30000");
    $this->assertEquals("My account", $this->getText("css=#secondary-menu-links li.first a"));
    for ($second = 0; ; $second++) {
      if ($second >= 60) $this->fail("timeout");
      try {
        if ($this->isElementPresent("link=Log out")) break;
      } catch (Exception $e) {}
      sleep(1);
    }

    $this->click("link=Log out");
    $this->waitForPageToLoad("30000");
  }
}
?>
